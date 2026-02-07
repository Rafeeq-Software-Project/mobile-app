import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import '../../data/models/project_data_model.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';
import '../widgets/review_info_row.dart';

class Step4ReviewScreen extends StatelessWidget {
  final ProjectDataModel projectData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step4ReviewScreen({
    super.key,
    required this.projectData,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.grey0,
      appBar: AppBar(
        backgroundColor: colors.grey0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.grey900),
          onPressed: onBack,
        ),
        title: Text(
          'Review & Publish',
          style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: colors.grey700),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            color: colors.grey0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: index < 3 ? 80.w : 80.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: index < 3 ? colors.primary800 : colors.grey300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                );
              }),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Ready to launch?',
                    style: AppTextStyles.font24Bold.copyWith(
                      color: colors.grey900,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Review your project details one last time before going live in the Rafeeq community.',
                    style: AppTextStyles.font14Regular.copyWith(
                      color: colors.grey600,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Project Preview Card
                  Container(
                    decoration: BoxDecoration(
                      color: colors.grey50,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: colors.grey300.withValues(alpha: .3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Image
                        if (projectData.coverImagePath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16.r),
                            ),
                            child: Container(
                              height: 180.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: colors.grey600),

                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [colors.accent600, colors.primary700],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.water_drop,
                                      size: 64.sp,
                                      color: colors.grey0.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 12.h,
                                    right: 12.w,
                                    child: Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: colors.grey0.withValues(
                                          alpha: .9,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        size: 18.sp,
                                        color: colors.grey700,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16.h,
                                    left: 16.w,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.grey600,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.verified,
                                            size: 14.sp,
                                            color: colors.grey0,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'SUSTAINABILITY PROFILE',
                                            style: AppTextStyles.font12Bold
                                                .copyWith(
                                                  color: colors.grey0,
                                                  letterSpacing: 0.5,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Project Info
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                projectData.projectName,
                                style: AppTextStyles.font20Bold.copyWith(
                                  color: colors.grey900,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 14.sp,
                                    color: colors.grey600,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'Cairo, Egypt',
                                    style: AppTextStyles.font12Regular.copyWith(
                                      color: colors.grey600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                projectData.problemStatement,
                                style: AppTextStyles.font14Regular.copyWith(
                                  color: colors.grey700,
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Project Details Section
                  Text(
                    'PROJECT DETAILS',
                    style: AppTextStyles.font12Bold.copyWith(
                      color: colors.grey600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors.grey50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colors.grey200),
                    ),
                    child: Column(
                      children: [
                        ReviewInfoRow(
                          icon: Icons.account_balance_wallet_outlined,
                          label: 'Funding Goal',
                          value:
                              '\$${projectData.requiredFunding.toStringAsFixed(0)} ${projectData.currency}',
                          iconColor: colors.primary700,
                        ),
                        Divider(height: 24.h, color: colors.grey200),
                        ReviewInfoRow(
                          icon: Icons.calendar_today_outlined,
                          label: 'Type',
                          value: projectData.fundingType,
                          iconColor: colors.accent600,
                        ),
                        Divider(height: 24.h, color: colors.grey200),
                        ReviewInfoRow(
                          icon: Icons.people_outline,
                          label: '4 Founders, 12 Volunteers',
                          value: '',
                          iconColor: colors.warning500,
                        ),
                        Divider(height: 24.h, color: colors.grey200),
                        ReviewInfoRow(
                          icon: Icons.schedule_outlined,
                          label: 'Launch Date',
                          value: 'Dec 15, 2025',
                          iconColor: colors.grey600,
                        ),
                        Divider(height: 24.h, color: colors.grey200),
                        ReviewInfoRow(
                          icon: Icons.access_time_outlined,
                          label: 'Timeline',
                          value: '6 Months',
                          iconColor: colors.info700,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Compliance Checkbox
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colors.primary800.withValues(alpha: .05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: colors.primary800.withValues(alpha: .2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: colors.primary800,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Agree to the Terms of Service',
                                style: AppTextStyles.font14SemiBold.copyWith(
                                  color: colors.grey900,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'I confirm that all information provided is accurate and complete and that I agree to Rafeeq\'s community guidelines.',
                                style: AppTextStyles.font12Regular.copyWith(
                                  color: colors.grey600,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
            child: Row(
              children: [
                Expanded(
                  child: SecondaryButton(label: 'Preview', onPressed: () {}),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: PrimaryButton(
                    label: 'Publish Project',
                    icon: Icons.rocket_launch,
                    onPressed: onNext,
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
