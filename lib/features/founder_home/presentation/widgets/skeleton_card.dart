import 'package:rafeeq_app/core/utils/common_imports.dart';

class SkeletonCard extends StatelessWidget {
  final double shimmerValue;
  final dynamic colors;
  const SkeletonCard({
    super.key,
    required this.shimmerValue,
    required this.colors,
  });

  Widget _bone({
    required double width,
    required double height,
    double radius = 6,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment(shimmerValue - 1, 0),
          end: Alignment(shimmerValue + 1, 0),
          colors: [colors.grey200, colors.grey50, colors.grey200],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey0,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: colors.grey200),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .25),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: badge + title + arrow ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Index badge bone
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    begin: Alignment(shimmerValue - 1, 0),
                    end: Alignment(shimmerValue + 1, 0),
                    colors: [colors.grey200, colors.grey100, colors.grey200],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bone(width: double.infinity, height: 14.h, radius: 6),
                    SizedBox(height: 6.h),
                    _bone(width: 120.w, height: 14.h, radius: 6),
                    SizedBox(height: 8.h),
                    // Status chip bone
                    _bone(width: 72.w, height: 20.h, radius: 20),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              _bone(width: 14.w, height: 14.h, radius: 4),
            ],
          ),

          // ── Divider bone ──
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: _bone(width: double.infinity, height: 1, radius: 1),
          ),

          // ── Bottom row: date + funding + button ──
          Row(
            children: [
              _bone(width: 14.w, height: 14.h),
              SizedBox(width: 5.w),
              _bone(width: 90.w, height: 12.h),
              SizedBox(width: 14.w),
              _bone(width: 14.w, height: 14.h),
              SizedBox(width: 4.w),
              _bone(width: 50.w, height: 12.h),
              const Spacer(),
              // Continue button bone
              _bone(width: 88.w, height: 32.h, radius: 10),
            ],
          ),
        ],
      ),
    );
  }
}
