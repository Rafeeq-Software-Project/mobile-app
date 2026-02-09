import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';

class ProfileAppBar extends StatelessWidget {
  final VoidCallback onBackTap, onEditTap;
  const ProfileAppBar({
    super.key,
    required this.onBackTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(color: colors.grey0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: colors.grey900, size: 24.sp),
            onPressed: onBackTap,
          ),
          Expanded(
            child: Text(
              'My Profile',
              style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: onEditTap,
            child: Text(
              'Edit',
              style: AppTextStyles.font14SemiBold.copyWith(
                color: colors.primary800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeaderCard extends StatelessWidget {
  final String name, title, location, imageUrl, bio;
  final bool isVerified;
  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.isVerified,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .2),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.primary800, width: 3),
                ),
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              if (isVerified)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: colors.primary800,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: colors.white,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            name,
            style: AppTextStyles.font20Bold.copyWith(color: colors.grey900),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user, size: 14.sp, color: colors.primary800),
              SizedBox(width: 4.w),
              Text(
                title,
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: colors.primary800,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 4.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.grey400,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.location_on_outlined,
                size: 14.sp,
                color: colors.grey600,
              ),
              Text(
                location,
                style: AppTextStyles.font13Regular.copyWith(
                  color: colors.grey600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            bio,
            style: AppTextStyles.font14Regular.copyWith(
              color: colors.grey700,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProfileStatsRow extends StatelessWidget {
  final int startupsReviewed, yearsActive;
  final double totalFunds;
  const ProfileStatsRow({
    super.key,
    required this.startupsReviewed,
    required this.yearsActive,
    required this.totalFunds,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStat(
              'Startups\nReviewed',
              startupsReviewed.toString(),
              colors,
            ),
          ),
          Container(width: 1, height: 40.h, color: colors.grey300),
          Expanded(
            child: _buildStat('Years Active', yearsActive.toString(), colors),
          ),
          Container(width: 1, height: 40.h, color: colors.grey300),
          Expanded(
            child: _buildStat(
              'Funds\nDeployed',
              '\$${(totalFunds / 1000000).toStringAsFixed(0)}M',
              colors,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, CustomAppColors colors) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.font20Bold.copyWith(color: colors.grey900),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppTextStyles.font12Regular.copyWith(color: colors.grey600),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }
}

class ProfileTabs extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabChanged;
  const ProfileTabs({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    final tabs = ['Interests', 'Portfolio', 'Reviews'];
    return Container(
      color: colors.grey0,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabs.map((tab) {
          final isSelected = tab == selectedTab;
          return GestureDetector(
            onTap: () => onTabChanged(tab),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? colors.primary800 : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                tab,
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: isSelected ? colors.primary800 : colors.grey600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FocusAreasGrid extends StatelessWidget {
  final List<String> focusAreas;
  const FocusAreasGrid({super.key, required this.focusAreas});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Focus Areas',
          style: AppTextStyles.font16Bold.copyWith(color: colors.grey900),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.grey50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: focusAreas
                .map(
                  (area) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary800.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: colors.primary700.withValues(alpha: .3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getIcon(area),
                          size: 16.sp,
                          color: colors.primary800,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          area,
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: colors.primary800,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  IconData _getIcon(String area) {
    if (area.contains('FinTech')) return Icons.account_balance;
    if (area.contains('AI')) return Icons.psychology;
    if (area.contains('Sustain')) return Icons.eco;
    if (area.contains('commerce')) return Icons.shopping_bag;
    if (area.contains('Health')) return Icons.medical_services;
    if (area.contains('Ed')) return Icons.school;
    return Icons.star;
  }
}

class RecentInvestmentsList extends StatelessWidget {
  final List<InvestmentModel> investments;
  const RecentInvestmentsList({super.key, required this.investments});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Investments',
                style: AppTextStyles.font16Bold.copyWith(color: colors.grey900),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: AppTextStyles.font12SemiBold.copyWith(
                        color: colors.primary800,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 16.sp,
                      color: colors.primary800,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          color: colors.grey0,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: investments.length,
            separatorBuilder: (c, i) =>
                Divider(height: 1, color: colors.grey200),
            itemBuilder: (c, i) => _buildInvestmentItem(investments[i], colors),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentItem(
    InvestmentModel investment,
    CustomAppColors colors,
  ) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: _getStatusColor(
                investment.status,
                colors,
              ).withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.rocket_launch,
              color: _getStatusColor(investment.status, colors),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  investment.name,
                  style: AppTextStyles.font14Bold.copyWith(
                    color: colors.grey900,
                  ),
                ),
                Text(
                  investment.date,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: colors.grey600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${investment.amount}k',
                style: AppTextStyles.font14Bold.copyWith(color: colors.grey900),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    investment.status,
                    colors,
                  ).withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  investment.status,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: _getStatusColor(investment.status, colors),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status, CustomAppColors colors) {
    if (status == 'Active') return colors.accent600;
    if (status == 'Exited') return colors.warning500;
    return colors.grey600;
  }
}
