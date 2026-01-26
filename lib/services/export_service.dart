import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:mokrabela/models/stats_models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  /// Generate and share CSV file of session data
  Future<void> exportToCSV(
    List<QueryDocumentSnapshot> sessions,
    String childId,
  ) async {
    final List<List<dynamic>> rows = [];

    // Header row
    rows.add([
      'Date',
      'Time',
      'Duration (min)',
      'Type',
      'Stress Before',
      'Stress After',
      'Stress Reduction',
    ]);

    // Data rows
    for (final session in sessions) {
      final data = session.data() as Map<String, dynamic>;
      final startTime = (data['startTime'] as Timestamp?)?.toDate();

      if (startTime == null) continue;

      final duration = (data['duration'] as num?)?.toInt() ?? 0;
      final type = data['exerciseName'] ?? data['type'] ?? 'Unknown';
      final stressBefore = (data['stressLevelBefore'] as num?)?.toInt();
      final stressAfter = (data['stressLevelAfter'] as num?)?.toInt();
      final reduction = (stressBefore != null && stressAfter != null)
          ? (stressBefore - stressAfter)
          : '';

      rows.add([
        DateFormat('yyyy-MM-dd').format(startTime),
        DateFormat('HH:mm').format(startTime),
        (duration / 60).toStringAsFixed(1),
        type,
        stressBefore ?? '',
        stressAfter ?? '',
        reduction,
      ]);
    }

    final csvData = const ListToCsvConverter().convert(rows);

    // Save locally
    final directory = await getApplicationDocumentsDirectory();
    final path =
        '${directory.path}/mokrabela_stats_${DateFormat('yyyyMMdd').format(DateTime.now())}.csv';
    final file = File(path);
    await file.writeAsString(csvData);

    // Share
    await Share.shareXFiles([
      XFile(path),
    ], text: 'Mokrabela Progress Report (CSV)');
  }

  /// Generate and share PDF report
  Future<void> exportToPDF(
    StatsData stats,
    List<DailySessionCount> dailyStats,
    List<WeekProgress> weeks,
    String childName,
  ) async {
    final doc = pw.Document();
    final font = await PdfGoogleFonts.spaceGroteskRegular();
    final boldFont = await PdfGoogleFonts.spaceGroteskBold();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: font, bold: boldFont),
        build: (pw.Context context) {
          return [
            // Header
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Mokrabela Progress Report',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    DateFormat('MMM d, yyyy').format(DateTime.now()),
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            // Child Info
            pw.Text(
              'Report for: $childName',
              style: pw.TextStyle(fontSize: 18, color: PdfColors.deepPurple),
            ),
            pw.Divider(),
            pw.SizedBox(height: 20),

            // Summary Stats Grid
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _buildPdfStatCard(
                  'Total Sessions',
                  stats.totalSessions.toString(),
                ),
                _buildPdfStatCard('Calm Minutes', '${stats.totalMinutes}m'),
                _buildPdfStatCard(
                  'Avg Stress Reduction',
                  stats.avgStressReduction.toStringAsFixed(1),
                ),
              ],
            ),

            pw.SizedBox(height: 40),

            // Protocol Progress Table
            pw.Text(
              'Protocol Process',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              context: context,
              headers: ['Week', 'Progress', 'Status'],
              data: weeks
                  .map(
                    (week) => [
                      'Week ${week.weekIndex}',
                      '${week.progressPercent.toInt()}%',
                      week.progressPercent >= 100 ? 'Completed' : 'In Progress',
                    ],
                  )
                  .toList(),
            ),

            pw.SizedBox(height: 40),

            pw.Footer(
              leading: pw.Text('Generated by Mokrabela App'),
              trailing: pw.Text('Page 1'),
            ),
          ];
        },
      ),
    );

    // Save and Share
    final bytes = await doc.save();
    final directory = await getApplicationDocumentsDirectory();
    final path =
        '${directory.path}/report_${DateFormat('yyyyMMdd').format(DateTime.now())}.pdf';
    final file = File(path);
    await file.writeAsBytes(bytes);

    await Share.shareXFiles([
      XFile(path),
    ], text: 'Mokrabela Progress Report (PDF)');
  }

  pw.Widget _buildPdfStatCard(String title, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 20,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.blueAccent,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            title,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
        ],
      ),
    );
  }
}
