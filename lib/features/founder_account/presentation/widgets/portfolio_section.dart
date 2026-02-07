import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/founder_account/data/models/user_profile_model.dart';

class PortfolioSection extends StatelessWidget {
  final List<PortfolioProject> portfolio;

  const PortfolioSection({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      color: colors.grey0,
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Portfolio',
                style: AppTextStyles.font16Bold.copyWith(color: colors.grey900),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.primary800,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.sp,
                      color: colors.primary800,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Portfolio Grid
          SizedBox(
            height: 200.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: portfolio.length,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final project = portfolio[index];
                return _buildPortfolioCard(context, project, colors);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioCard(
    BuildContext context,
    PortfolioProject project,
    CustomAppColors colors,
  ) {
    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: project.imageUrl == 'analytics'
                        ? [const Color(0xFF1A237E), const Color(0xFF283593)]
                        : [const Color(0xFF2E7D32), const Color(0xFF43A047)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Pattern or Icon
                    Center(
                      child: Icon(
                        project.imageUrl == 'analytics'
                            ? Icons.bar_chart
                            : Icons.eco,
                        size: 48.sp,
                        color: colors.grey0.withValues(alpha: 0.3),
                      ),
                    ),
                    // Tag
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: project.tag == 'Exited'
                              ? colors.primary800
                              : colors.accent600,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          project.tag,
                          style: AppTextStyles.font12Bold.copyWith(
                            color: colors.grey0,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Info
            Container(
              padding: EdgeInsets.all(12.w),
              color: colors.grey50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: AppTextStyles.font14Bold.copyWith(
                      color: colors.grey900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    project.description,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: colors.grey600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
