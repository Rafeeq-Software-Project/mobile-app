import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_explore_projects/data/models/explore_project_model.dart';
import '../widgets/explore_app_bar.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/trending_section.dart';
import '../widgets/opportunities_section.dart';
import 'project_details_screen.dart';

class ExploreProjectsScreen extends StatefulWidget {
  const ExploreProjectsScreen({super.key});

  @override
  State<ExploreProjectsScreen> createState() => _ExploreProjectsScreenState();
}

class _ExploreProjectsScreenState extends State<ExploreProjectsScreen> {
  List<ExploreProjectModel> trendingProjects = [];
  List<ExploreProjectModel> opportunities = [];
  String selectedCategory = 'All Sectors';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      trendingProjects = ExploreProjectModel.getSampleTrending();
      opportunities = ExploreProjectModel.getSampleOpportunities();
    });
  }

  void _toggleBookmark(String id) {
    setState(() {
      // Update in trending
      final trendingIndex = trendingProjects.indexWhere((p) => p.id == id);
      if (trendingIndex != -1) {
        trendingProjects[trendingIndex] = trendingProjects[trendingIndex]
            .copyWith(
              isBookmarked: !trendingProjects[trendingIndex].isBookmarked,
            );
      }

      // Update in opportunities
      final oppIndex = opportunities.indexWhere((p) => p.id == id);
      if (oppIndex != -1) {
        opportunities[oppIndex] = opportunities[oppIndex].copyWith(
          isBookmarked: !opportunities[oppIndex].isBookmarked,
        );
      }
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _navigateToDetails(ExploreProjectModel project) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProjectDetailsScreen()),
    );
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
            ExploreAppBar(onNotificationTap: () {}, onBookmarkTap: () {}),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Search & Filter
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SearchFilterBar(
                        controller: _searchController,
                        onSearch: (query) {},
                        onFilterTap: () {},
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Category Filters
                    CategoryFilterChips(
                      selectedCategory: selectedCategory,
                      onCategorySelected: _onCategorySelected,
                    ),
                    SizedBox(height: 24.h),

                    // Trending Section
                    TrendingSection(
                      projects: trendingProjects,
                      onBookmarkToggle: _toggleBookmark,
                      onProjectTap: _navigateToDetails,
                    ),
                    SizedBox(height: 24.h),

                    // Opportunities Section
                    OpportunitiesSection(
                      projects: opportunities,
                      onBookmarkToggle: _toggleBookmark,
                      onProjectTap: _navigateToDetails,
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
