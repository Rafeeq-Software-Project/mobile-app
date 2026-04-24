import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 48.h),

                    // Success icon with ripple
                    ZoomIn(
                      duration: const Duration(milliseconds: 700),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glow ring
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.primary800.withValues(alpha: .08),
                            ),
                          ),
                          // Middle ring
                          Container(
                            width: 112.w,
                            height: 112.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.primary800.withValues(alpha: .12),
                            ),
                          ),
                          // Icon circle
                          Container(
                            width: 88.w,
                            height: 88.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [colors.primary800, colors.accent600],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: colors.primary700.withValues(
                                    alpha: .4,
                                  ),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              size: 44.sp,
                              color: colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Title
                    FadeInDown(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        '🎉 Project Published!',
                        style: AppTextStyles.font16Bold.copyWith(
                          color: colors.grey900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 400),
                      child: Text(
                        '"${projectData.name}" is now live and visible\nto the Rafeeq community.',
                        style: AppTextStyles.font14Regular.copyWith(
                          color: colors.grey600,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 36.h),

                    // Stats row
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 500),
                      child: Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: Icons.visibility_outlined,
                              value: '2.3K',
                              label: 'Expected Reach',
                              color: colors.primary800,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.handshake_outlined,
                              value: '45',
                              label: 'Potential Matches',
                              color: colors.accent600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // What's Next
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 600),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: colors.grey50,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(color: colors.grey200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "What's Next?",
                              style: AppTextStyles.font16Bold.copyWith(
                                color: colors.grey900,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            _NextStepTile(
                              icon: Icons.notifications_active_outlined,
                              title: 'Get Notified',
                              subtitle:
                                  'We\'ll alert you when investors show interest',
                              delay: 650,
                            ),
                            SizedBox(height: 12.h),
                            _NextStepTile(
                              icon: Icons.analytics_outlined,
                              title: 'Track Performance',
                              subtitle: 'Monitor views, likes, and engagement',
                              delay: 720,
                            ),
                            SizedBox(height: 12.h),
                            _NextStepTile(
                              icon: Icons.campaign_outlined,
                              title: 'Share Your Project',
                              subtitle:
                                  'Spread the word to gain traction faster',
                              delay: 790,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Quick Actions
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'QUICK ACTIONS',
                            style: AppTextStyles.font12Bold.copyWith(
                              color: colors.grey500,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                child: _QuickAction(
                                  icon: Icons.share_outlined,
                                  label: 'Share',
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: _QuickAction(
                                  icon: Icons.edit_outlined,
                                  label: 'Edit',
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: _QuickAction(
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
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 800),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: colors.grey0,
                  boxShadow: [
                    BoxShadow(
                      color: colors.grey300.withValues(alpha: .3),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    PrimaryButton(
                      label: 'View My Project',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () =>
                          Navigator.of(context).popUntil((r) => r.isFirst),
                    ),
                    SizedBox(height: 12.h),
                    SecondaryButton(
                      label: 'Back to Dashboard',
                      onPressed: () =>
                          Navigator.of(context).popUntil((r) => r.isFirst),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: color.withValues(alpha: .25)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 26.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.font20Bold.copyWith(color: colors.grey900),
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
}

class _NextStepTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int delay;

  const _NextStepTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return FadeInLeft(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: delay),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colors.primary800.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 18.sp, color: colors.primary800),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: colors.grey900,
                  ),
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
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: colors.grey200),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, size: 22.sp, color: colors.grey700),
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
