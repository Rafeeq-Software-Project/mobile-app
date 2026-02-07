import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../../data/models/project_data_model.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

class Step5SuccessScreen extends StatelessWidget {
  final ProjectDataModel projectData;

  const Step5SuccessScreen({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.grey0,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [colors.accent600, colors.primary700],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colors.primary700.withValues(alpha: .3),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 64.sp,
                        color: colors.white,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      '🎉 Project Published!',
                      style: AppTextStyles.font32Bold.copyWith(
                        color: colors.grey900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Your project "${projectData.projectName}" is now live and visible to the Rafeeq community.',
                      style: AppTextStyles.font16Regular.copyWith(
                        color: colors.grey600,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),

                    // Stats Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            context,
                            icon: Icons.visibility_outlined,
                            value: '2.3K',
                            label: 'Expected Reach',
                            color: colors.primary700,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildStatCard(
                            context,
                            icon: Icons.people_outline,
                            value: '45',
                            label: 'Potential Matches',
                            color: colors.accent600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),

                    // Next Steps Section
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: colors.grey50,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: colors.grey200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What\'s Next?',
                            style: AppTextStyles.font18Bold.copyWith(
                              color: colors.grey900,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildNextStep(
                            context,
                            icon: Icons.notifications_active_outlined,
                            title: 'Get Notified',
                            subtitle:
                                'We\'ll alert you when investors show interest',
                          ),
                          SizedBox(height: 12.h),
                          _buildNextStep(
                            context,
                            icon: Icons.analytics_outlined,
                            title: 'Track Performance',
                            subtitle:
                                'Monitor views, likes, and engagement metrics',
                          ),
                          SizedBox(height: 12.h),
                          _buildNextStep(
                            context,
                            icon: Icons.campaign_outlined,
                            title: 'Share Your Project',
                            subtitle:
                                'Spread the word on social media to gain traction',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Quick Actions
                    Text(
                      'QUICK ACTIONS',
                      style: AppTextStyles.font12Bold.copyWith(
                        color: colors.grey600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickActionButton(
                            context,
                            icon: Icons.share_outlined,
                            label: 'Share',
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildQuickActionButton(
                            context,
                            icon: Icons.edit_outlined,
                            label: 'Edit Project',
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildQuickActionButton(
                            context,
                            icon: Icons.bar_chart_outlined,
                            label: 'Analytics',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: colors.grey0,
                boxShadow: [
                  BoxShadow(
                    color: colors.grey300.withValues(alpha: .3),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  PrimaryButton(
                    label: 'View My Project',
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                  SizedBox(height: 12.h),
                  SecondaryButton(
                    label: 'Back to Dashboard',
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    final colors = context.customAppColors;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: .3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.font24Bold.copyWith(color: colors.grey900),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTextStyles.font12Regular.copyWith(color: colors.grey600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNextStep(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final colors = context.customAppColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: colors.primary800.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: colors.primary800, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.font14Bold.copyWith(color: colors.grey900),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: AppTextStyles.font12Regular.copyWith(
                  color: colors.grey600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final colors = context.customAppColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: colors.grey300),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: colors.grey700, size: 24.sp),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTextStyles.font12SemiBold.copyWith(
                color: colors.grey700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
