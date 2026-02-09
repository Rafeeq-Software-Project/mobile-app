import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/features/investor_apply_project/data/models/application_model.dart';

class AppliedAppBar extends StatelessWidget {
  final VoidCallback onBackTap, onFilterTap;
  const AppliedAppBar({
    super.key,
    required this.onBackTap,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: colors.grey0,
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: colors.grey900),
            onPressed: onBackTap,
          ),
          Expanded(
            child: Text(
              'Applied Projects',
              style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.tune, color: colors.grey900),
            onPressed: onFilterTap,
          ),
        ],
      ),
    );
  }
}

class StatusFilterTabs extends StatelessWidget {
  final String selectedStatus;
  final Function(String) onStatusChanged;
  const StatusFilterTabs({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    final statuses = ['All', 'Pending', 'Approved', 'Rejected'];
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: statuses.length,
        separatorBuilder: (c, i) => SizedBox(width: 8.w),
        itemBuilder: (c, i) {
          final status = statuses[i];
          final isSelected = status == selectedStatus;
          return GestureDetector(
            onTap: () => onStatusChanged(status),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected ? colors.primary800 : colors.grey0,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? colors.primary800 : colors.grey300,
                ),
              ),
              child: Text(
                status,
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: isSelected ? colors.grey0 : colors.grey700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InvestmentSummaryCard extends StatelessWidget {
  final double totalInvested;
  const InvestmentSummaryCard({super.key, required this.totalInvested});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary800, colors.primary500],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.primary700.withValues(alpha: .3),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Investment Amount',
            style: AppTextStyles.font12Regular.copyWith(
              color: colors.white.withValues(alpha: .8),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '\$${totalInvested.toStringAsFixed(0)}',
            style: AppTextStyles.font32Bold.copyWith(color: colors.white),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.arrow_forward,
                size: 16.sp,
                color: colors.white.withValues(alpha: .8),
              ),
              SizedBox(width: 4.w),
              Text(
                'View Investment History',
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: colors.white.withValues(alpha: .9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ApplicationListItem extends StatelessWidget {
  final ApplicationModel application;
  final VoidCallback onTap;
  const ApplicationListItem({
    super.key,
    required this.application,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: _getGradient(application.imageUrl),
              ),
              child: Icon(
                _getIcon(application.imageUrl),
                color: colors.white,
                size: 28.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    application.projectName,
                    style: AppTextStyles.font16Bold.copyWith(
                      color: colors.grey900,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12.sp,
                        color: colors.grey600,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        application.founderName,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: colors.grey600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Proposal Amount',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: colors.grey600,
                    ),
                  ),
                  Text(
                    '\$${application.proposedAmount.toStringAsFixed(0)}',
                    style: AppTextStyles.font14Bold.copyWith(
                      color: colors.grey900,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      application.status,
                      colors,
                    ).withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    application.status,
                    style: AppTextStyles.font12Bold.copyWith(
                      color: _getStatusColor(application.status, colors),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Icon(Icons.chevron_right, color: colors.grey400),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _getGradient(String img) {
    if (img == 'green')
      return LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)]);
    if (img == 'logistics')
      return LinearGradient(colors: [Color(0xFF757575), Color(0xFF9E9E9E)]);
    return LinearGradient(colors: [Color(0xFF2196F3), Color(0xFF42A5F5)]);
  }

  IconData _getIcon(String img) {
    if (img == 'green') return Icons.eco;
    if (img == 'logistics') return Icons.local_shipping;
    return Icons.medical_services;
  }

  Color _getStatusColor(String status, CustomAppColors colors) {
    if (status == 'Approved') return colors.accent600;
    if (status == 'Rejected') return colors.error500;
    return colors.warning500;
  }
}
