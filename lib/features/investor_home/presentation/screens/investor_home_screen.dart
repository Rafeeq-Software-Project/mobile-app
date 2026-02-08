import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_home/data/models/opportunity_model.dart';
import 'package:rafeeq_app/features/investor_home/presentation/widgets/category_chips.dart';
import 'package:rafeeq_app/features/investor_home/presentation/widgets/home_app_bar.dart';
import 'package:rafeeq_app/features/investor_home/presentation/widgets/recent_opportunities_section.dart';
import 'package:rafeeq_app/features/investor_home/presentation/widgets/search_bar_widget.dart';
import 'package:rafeeq_app/features/investor_home/presentation/widgets/top_picks_section.dart';
import 'package:rafeeq_app/features/investor_home/presentation/widgets/welcome_header.dart';

class InvestorHomeScreen extends StatefulWidget {
  const InvestorHomeScreen({super.key});

  @override
  State<InvestorHomeScreen> createState() => _InvestorHomeScreenState();
}

class _InvestorHomeScreenState extends State<InvestorHomeScreen> {
  List<OpportunityModel> opportunities = [];
  List<OpportunityModel> topPicks = [];
  List<OpportunityModel> recentOpportunities = [];

  String selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final allOpportunities = OpportunityModel.getSampleData();
    setState(() {
      opportunities = allOpportunities;
      topPicks = allOpportunities.where((o) => o.tag != null).toList();
      recentOpportunities = allOpportunities
          .where((o) => o.tag == null)
          .toList();
    });
  }

  void _toggleBookmark(String id) {
    setState(() {
      final index = opportunities.indexWhere((o) => o.id == id);
      if (index != -1) {
        opportunities[index] = opportunities[index].copyWith(
          isBookmarked: !opportunities[index].isBookmarked,
        );
      }

      // Update in sublists
      final topPickIndex = topPicks.indexWhere((o) => o.id == id);
      if (topPickIndex != -1) {
        topPicks[topPickIndex] = topPicks[topPickIndex].copyWith(
          isBookmarked: !topPicks[topPickIndex].isBookmarked,
        );
      }

      final recentIndex = recentOpportunities.indexWhere((o) => o.id == id);
      if (recentIndex != -1) {
        recentOpportunities[recentIndex] = recentOpportunities[recentIndex]
            .copyWith(
              isBookmarked: !recentOpportunities[recentIndex].isBookmarked,
            );
      }
    });

    // Show snackbar
    final opportunity = opportunities.firstWhere((o) => o.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          opportunity.isBookmarked
              ? 'Saved to bookmarks'
              : 'Removed from bookmarks',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: context.customAppColors.accent600,
      ),
    );
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    // Here you can filter opportunities based on category
  }

  void _onSearch(String query) {
    // Implement search logic
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            HomeAppBar(userName: 'Ahmed', onNotificationTap: () {}),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    // Welcome Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: const WelcomeHeader(),
                    ),
                    SizedBox(height: 20.h),
                    // Search Bar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SearchBarWidget(
                        controller: _searchController,
                        onSearch: _onSearch,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Category Chips
                    CategoryChips(
                      selectedCategory: selectedCategory,
                      onCategorySelected: _onCategorySelected,
                    ),
                    SizedBox(height: 24.h),
                    // Top Picks Section
                    TopPicksSection(
                      opportunities: topPicks,
                      onBookmarkToggle: _toggleBookmark,
                    ),
                    SizedBox(height: 24.h),
                    // Recent Opportunities Section
                    RecentOpportunitiesSection(
                      opportunities: recentOpportunities,
                      onBookmarkToggle: _toggleBookmark,
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
