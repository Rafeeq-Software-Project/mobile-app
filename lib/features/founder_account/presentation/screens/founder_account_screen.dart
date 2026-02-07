import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/founder_account/data/models/user_profile_model.dart';
import '../widgets/profile_header.dart';
import '../widgets/stats_row.dart';
import '../widgets/about_section.dart';
import '../widgets/current_venture_card.dart';
import '../widgets/portfolio_section.dart';
import '../widgets/reputation_section.dart';
import '../widgets/action_buttons_row.dart';

class FounderAccountScreen extends StatefulWidget {
  const FounderAccountScreen({super.key});

  @override
  State<FounderAccountScreen> createState() => _FounderAccountScreenState();
}

class _FounderAccountScreenState extends State<FounderAccountScreen> {
  late UserProfileModel userProfile;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    userProfile = UserProfileModel.sample();
  }

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
      if (isFollowing) {
        userProfile = UserProfileModel(
          name: userProfile.name,
          location: userProfile.location,
          isVerified: userProfile.isVerified,
          profileImageUrl: userProfile.profileImageUrl,
          followers: userProfile.followers + 1,
          projectsCount: userProfile.projectsCount,
          successRate: userProfile.successRate,
          aboutMe: userProfile.aboutMe,
          skills: userProfile.skills,
          currentVenture: userProfile.currentVenture,
          portfolio: userProfile.portfolio,
          reputation: userProfile.reputation,
        );
      } else {
        userProfile = UserProfileModel(
          name: userProfile.name,
          location: userProfile.location,
          isVerified: userProfile.isVerified,
          profileImageUrl: userProfile.profileImageUrl,
          followers: userProfile.followers - 1,
          projectsCount: userProfile.projectsCount,
          successRate: userProfile.successRate,
          aboutMe: userProfile.aboutMe,
          skills: userProfile.skills,
          currentVenture: userProfile.currentVenture,
          portfolio: userProfile.portfolio,
          reputation: userProfile.reputation,
        );
      }
    });
  }

  void _shareProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile link copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.customAppColors.accent600,
      ),
    );
  }

  void _createNewProject() {
    GoRouter.of(context).push(Routes.createProjectSteps);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.grey0,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: colors.grey0,
            elevation: 0,
            pinned: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colors.grey900),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'My Profile',
              style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.settings_outlined, color: colors.grey900),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.edit_outlined, color: colors.grey900),
                onPressed: () {},
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Profile Header
                Container(
                  color: colors.grey0,
                  child: ProfileHeader(
                    profileImageUrl: userProfile.profileImageUrl,
                    name: userProfile.name,
                    location: userProfile.location,
                    isVerified: userProfile.isVerified,
                    followers: userProfile.followers,
                    isFollowing: isFollowing,
                    onFollowToggle: _toggleFollow,
                  ),
                ),
                SizedBox(height: 1.h),

                // Stats Row
                Container(
                  color: colors.grey0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: StatsRow(
                    projectsCount: userProfile.projectsCount,
                    successRate: userProfile.successRate,
                  ),
                ),
                SizedBox(height: 12.h),

                // About Me Section
                AboutSection(
                  aboutMe: userProfile.aboutMe,
                  skills: userProfile.skills,
                ),
                SizedBox(height: 12.h),

                // Current Venture
                if (userProfile.currentVenture != null)
                  CurrentVentureCard(venture: userProfile.currentVenture!),
                if (userProfile.currentVenture != null) SizedBox(height: 12.h),

                // Portfolio
                PortfolioSection(portfolio: userProfile.portfolio),
                SizedBox(height: 12.h),

                // Reputation
                ReputationSection(reputation: userProfile.reputation),
                SizedBox(height: 80.h), // Space for floating buttons
              ],
            ),
          ),
        ],
      ),

      // Floating Action Buttons
      bottomNavigationBar: ActionButtonsRow(
        onShare: _shareProfile,
        onNewProject: _createNewProject,
      ),
    );
  }
}
