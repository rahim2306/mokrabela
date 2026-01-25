import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:gal/gal.dart';

class DrawingPath {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  DrawingPath({
    required this.points,
    required this.color,
    this.strokeWidth = 4.0,
  });
}

class DrawingCanvasScreen extends StatefulWidget {
  const DrawingCanvasScreen({super.key});

  @override
  State<DrawingCanvasScreen> createState() => _DrawingCanvasScreenState();
}

class _DrawingCanvasScreenState extends State<DrawingCanvasScreen> {
  final GlobalKey _canvasKey = GlobalKey();
  bool _isSaving = false;

  final List<DrawingPath> _paths = [];
  Color _selectedColor = const Color(0xFFF5576C);
  final double _strokeWidth = 4.0;

  void _clear() {
    setState(() {
      _paths.clear();
    });
  }

  Future<void> _saveToGallery() async {
    try {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.galleryPermissionRequired,
                ),
              ),
            );
          }
          return;
        }
      }

      final RenderRepaintBoundary? boundary =
          _canvasKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;

      if (boundary == null) return;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return;

      await Gal.putImageBytes(
        byteData.buffer.asUint8List(),
        name: "MokraBela_Drawing_${DateTime.now().millisecondsSinceEpoch}",
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.savedToGallery)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.galleryError(e.toString()),
            ),
          ),
        );
      }
    }
  }

  Future<void> _handleSaveFlow() async {
    setState(() => _isSaving = true);

    try {
      // Save to Gallery only
      await _saveToGallery();

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.saveError(e.toString()),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, size: 24.sp),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    l10n.drawingCanvas,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _clear,
                    icon: Icon(Icons.delete_outline_rounded, size: 18.sp),
                    label: Text(l10n.clearCanvas),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                ],
              ),
            ),

            // Canvas
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey[200]!, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        _paths.add(
                          DrawingPath(
                            points: [details.localPosition],
                            color: _selectedColor,
                            strokeWidth: _strokeWidth,
                          ),
                        );
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        _paths.last.points.add(details.localPosition);
                      });
                    },
                    child: RepaintBoundary(
                      key: _canvasKey,
                      child: CustomPaint(
                        painter: DrawingPainter(paths: _paths),
                        size: Size.infinite,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Controls
            Container(
              padding: EdgeInsets.all(6.w),
              child: Column(
                children: [
                  // Color Picker
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildColorCircle(const Color(0xFFF5576C)),
                        _buildColorCircle(const Color(0xFFF093FB)),
                        _buildColorCircle(const Color(0xFF4ECDC4)),
                        _buildColorCircle(const Color(0xFFFFA751)),
                        _buildColorCircle(const Color(0xFF667EEA)),
                        _buildColorCircle(Colors.black),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  // Save Button
                  ElevatedButton(
                    onPressed: _isSaving ? null : _handleSaveFlow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF093FB),
                      minimumSize: Size(double.infinity, 7.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            l10n.saveDrawing,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    bool isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.grey[800]! : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPath> paths;

  DrawingPainter({required this.paths});

  @override
  void paint(Canvas canvas, Size size) {
    for (final path in paths) {
      final paint = Paint()
        ..color = path.color
        ..strokeWidth = path.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      if (path.points.length > 1) {
        for (int i = 0; i < path.points.length - 1; i++) {
          canvas.drawLine(path.points[i], path.points[i + 1], paint);
        }
      } else {
        canvas.drawCircle(path.points.first, path.strokeWidth / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}
