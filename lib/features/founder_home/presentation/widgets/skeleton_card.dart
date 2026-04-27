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
    double radius = 8,
    bool isPrimary = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment(shimmerValue - 1.5, 0),
          end: Alignment(shimmerValue + 1.5, 0),
          colors: isPrimary
              ? [
                  colors.primary800.withValues(alpha: .15),
                  colors.primary800.withValues(alpha: .08),
                  colors.primary800.withValues(alpha: .15),
                ]
              : [colors.grey200, colors.grey100, colors.grey200],
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
          // ── Top row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Index badge
              _bone(width: 36.w, height: 36.w, radius: 10, isPrimary: true),
              SizedBox(width: 12.w),
              // Title + status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    _bone(width: double.infinity, height: 13.h, radius: 6),
                    SizedBox(height: 6.h),
                    _bone(width: 160.w, height: 13.h, radius: 6),
                    SizedBox(height: 10.h),
                    // Status chip
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          begin: Alignment(shimmerValue - 1.5, 0),
                          end: Alignment(shimmerValue + 1.5, 0),
                          colors: [
                            colors.grey200,
                            colors.grey100,
                            colors.grey200,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _bone(width: 6.w, height: 6.w, radius: 100),
                          SizedBox(width: 5.w),
                          _bone(width: 48.w, height: 9.h, radius: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Arrow icon placeholder
              _bone(width: 12.w, height: 12.h, radius: 3),
            ],
          ),

          // ── Divider ──
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Container(height: 1, color: colors.grey100),
          ),

          // ── Bottom row ──
          Row(
            children: [
              // Date badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  gradient: LinearGradient(
                    begin: Alignment(shimmerValue - 1.5, 0),
                    end: Alignment(shimmerValue + 1.5, 0),
                    colors: [colors.grey200, colors.grey100, colors.grey200],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _bone(width: 11.w, height: 11.h, radius: 3),
                    SizedBox(width: 4.w),
                    _bone(width: 70.w, height: 10.h, radius: 4),
                  ],
                ),
              ),

              SizedBox(width: 10.w),

              // Funding amount
              Row(
                children: [
                  _bone(width: 13.w, height: 13.h, radius: 3),
                  SizedBox(width: 3.w),
                  _bone(width: 44.w, height: 10.h, radius: 4),
                ],
              ),

              const Spacer(),

              // Continue button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    begin: Alignment(shimmerValue - 1.5, 0),
                    end: Alignment(shimmerValue + 1.5, 0),
                    colors: [
                      colors.primary800.withValues(alpha: .2),
                      colors.primary800.withValues(alpha: .1),
                      colors.primary800.withValues(alpha: .2),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _bone(
                      width: 12.w,
                      height: 12.h,
                      radius: 3,
                      isPrimary: true,
                    ),
                    SizedBox(width: 5.w),
                    _bone(
                      width: 52.w,
                      height: 10.h,
                      radius: 4,
                      isPrimary: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
