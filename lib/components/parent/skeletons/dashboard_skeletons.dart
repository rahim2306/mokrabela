import 'package:flutter/material.dart';
import 'package:mokrabela/components/common/shimmer_loading.dart';
import 'package:sizer/sizer.dart';

class QuickStatsSkeleton extends StatelessWidget {
  const QuickStatsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Row(
        children: [
          Expanded(child: _buildCardSkeleton()),
          SizedBox(width: 3.w),
          Expanded(child: _buildCardSkeleton()),
          SizedBox(width: 3.w),
          Expanded(child: _buildCardSkeleton()),
        ],
      ),
    );
  }

  Widget _buildCardSkeleton() {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // No shadow to keep it flat during loading
      ),
      child: Column(
        children: [
          ShimmerLoadingBlock(
            width: 30,
            height: 30,
            borderRadius: 15,
          ), // Icon circle
          SizedBox(height: 1.5.h),
          ShimmerLoadingBlock(width: 50, height: 24, borderRadius: 4), // Value
          SizedBox(height: 1.h),
          ShimmerLoadingBlock(width: 40, height: 12, borderRadius: 4), // Label
        ],
      ),
    );
  }
}

class ProtocolRoadmapSkeleton extends StatelessWidget {
  const ProtocolRoadmapSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        height: 18.h,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: List.generate(
            3,
            (index) => Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerLoadingBlock(
                      width: 40,
                      height: 40,
                      borderRadius: 20,
                    ), // Circle
                    SizedBox(height: 1.5.h),
                    ShimmerLoadingBlock(
                      width: 60,
                      height: 14,
                      borderRadius: 4,
                    ), // Title
                    SizedBox(height: 0.5.h),
                    ShimmerLoadingBlock(
                      width: 40,
                      height: 10,
                      borderRadius: 4,
                    ), // Subtitle
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RecentActivitySkeleton extends StatelessWidget {
  const RecentActivitySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.only(bottom: 2.h),
            padding: EdgeInsets.all(1.5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ShimmerLoadingBlock(
                  width: 40,
                  height: 40,
                  borderRadius: 12,
                ), // Icon
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerLoadingBlock(
                        width: 40.w,
                        height: 14,
                        borderRadius: 4,
                      ), // Title
                      SizedBox(height: 1.h),
                      ShimmerLoadingBlock(
                        width: 20.w,
                        height: 10,
                        borderRadius: 4,
                      ), // Subtitle
                    ],
                  ),
                ),
                ShimmerLoadingBlock(
                  width: 15.w,
                  height: 12,
                  borderRadius: 4,
                ), // Time
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatsTabSkeleton extends StatelessWidget {
  const StatsTabSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(
                  child: ShimmerLoadingBlock(
                    width: 40.w,
                    height: 24,
                    borderRadius: 4,
                  ),
                ), // Title
                SizedBox(height: 2.h),
                Shimmer(
                  child: ShimmerLoadingBlock(
                    width: 90.w,
                    height: 40,
                    borderRadius: 20,
                  ),
                ), // Time Selector
              ],
            ),
          ),
          SizedBox(height: 3.h),

          // Summary Cards
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Shimmer(
              child: Row(
                children: [
                  Expanded(child: _buildSummaryCardSkeleton()),
                  SizedBox(width: 3.w),
                  Expanded(child: _buildSummaryCardSkeleton()),
                  SizedBox(width: 3.w),
                  Expanded(child: _buildSummaryCardSkeleton()),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h),

          // Charts
          _buildChartSkeleton(),
          SizedBox(height: 2.h),
          _buildChartSkeleton(),
        ],
      ),
    );
  }

  Widget _buildSummaryCardSkeleton() {
    return Container(
      height: 12.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildChartSkeleton() {
    return Shimmer(
      child: Container(
        height: 30.h,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
