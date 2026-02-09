import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';
import 'package:rafeeq_app/features/investor_account/presentation/widgets/investor_account_widgets.dart';

class InvestorAccountScreen extends StatefulWidget {
  const InvestorAccountScreen({super.key});

  @override
  State<InvestorAccountScreen> createState() => _InvestorAccountScreenState();
}

class _InvestorAccountScreenState extends State<InvestorAccountScreen> {
  late MyProfileModel profile;
  String selectedTab = 'Interests';

  @override
  void initState() {
    super.initState();
    profile = MyProfileModel.sample();
  }

  void _onTabChanged(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.grey0,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            ProfileAppBar(
              onBackTap: () => Navigator.pop(context),
              onEditTap: () {},
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),

                    // Profile Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ProfileHeaderCard(
                        name: profile.name,
                        title: profile.title,
                        location: profile.location,
                        imageUrl: profile.imageUrl,
                        isVerified: profile.isVerified,
                        bio: profile.bio,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Stats Row
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ProfileStatsRow(
                        startupsReviewed: profile.startupsReviewed,
                        yearsActive: profile.yearsActive,
                        totalFunds: profile.totalFunds,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Tabs
                    ProfileTabs(
                      selectedTab: selectedTab,
                      onTabChanged: _onTabChanged,
                    ),
                    SizedBox(height: 20.h),

                    // Content based on selected tab
                    if (selectedTab == 'Interests')
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: FocusAreasGrid(focusAreas: profile.focusAreas),
                      ),
                    if (selectedTab == 'Portfolio')
                      RecentInvestmentsList(
                        investments: profile.recentInvestments,
                      ),
                    if (selectedTab == 'Reviews')
                      Padding(
                        padding: EdgeInsets.all(40.w),
                        child: Text(
                          'No reviews yet',
                          style: AppTextStyles.font14Regular.copyWith(
                            color: colors.grey500,
                          ),
                        ),
                      ),
                    SizedBox(height: 20.h),
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
