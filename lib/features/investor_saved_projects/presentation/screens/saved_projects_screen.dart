import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/features/investor_saved_projects/data/models/saved_project_model.dart'
    show SavedProjectModel;
import 'package:rafeeq_app/features/investor_saved_projects/presentation/widgets/saved_widgets.dart';

class SavedProjectsScreen extends StatefulWidget {
  const SavedProjectsScreen({super.key});

  @override
  State<SavedProjectsScreen> createState() => _SavedProjectsScreenState();
}

class _SavedProjectsScreenState extends State<SavedProjectsScreen> {
  List<SavedProjectModel> projects = [];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _loadProjects() {
    setState(() {
      projects = SavedProjectModel.getSampleProjects();
    });
  }

  List<SavedProjectModel> get filteredProjects {
    if (selectedCategory == 'All') return projects;
    return projects.where((p) => p.category == selectedCategory).toList();
  }

  void _onCategoryChanged(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _toggleSaved(String id) {
    setState(() {
      final index = projects.indexWhere((p) => p.id == id);
      if (index != -1) {
        projects[index].isSaved = !projects[index].isSaved;
        if (!projects[index].isSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Removed from saved'),
              backgroundColor: CustomAppColors.of(context).grey700,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    final visibleProjects = filteredProjects.where((p) => p.isSaved).toList();

    return Scaffold(
      backgroundColor: colors.grey0,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            SavedAppBar(
              onBackTap: () => Navigator.pop(context),
              onSearchTap: () {},
            ),

            // Category Tabs
            CategoryTabs(
              selectedCategory: selectedCategory,
              onCategoryChanged: _onCategoryChanged,
            ),

            // Projects Grid
            Expanded(
              child: visibleProjects.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_border,
                            size: 64.sp,
                            color: colors.grey400,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No saved projects',
                            style: AppTextStyles.font16Regular.copyWith(
                              color: colors.grey600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(20.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: visibleProjects.length,
                      itemBuilder: (context, index) {
                        return SavedProjectCard(
                          project: visibleProjects[index],
                          onToggleSaved: _toggleSaved,
                          onTap: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
