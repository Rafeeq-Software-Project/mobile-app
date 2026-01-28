import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import '../widgets/filter_chip_button.dart';
import '../widgets/project_card.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({super.key});

  @override
  State<MyProjectsScreen> createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen> {
  String selectedFilter = 'All';

  final List<ProjectModel> projects = [
    ProjectModel(
      title: 'EcoGrow Vertical Farms',
      description:
          'Sustainable urban farming solution for high-density metropolitan areas.',
      status: 'Open',
      category: 'AgriTech',
      raisedAmount: 50000,
      goalAmount: 150000,
      statusLabel: '35% Funded',
      statusColor: 'green',
      imageUrl:
          'https://images.unsplash.com/photo-1530836369250-ef72a3f5cda8?w=400',
    ),
    ProjectModel(
      title: 'SolarLink Home Battery',
      description:
          'Affordable solar storage units for residential homes in developing regions.',
      status: 'Under Review',
      category: 'Clean Energy',
      raisedAmount: 0,
      goalAmount: 80000,
      statusLabel: '\$0 raised',
      statusColor: 'orange',
      imageUrl:
          'https://images.unsplash.com/photo-1509391366360-2e959784a276?w=400',
    ),
    ProjectModel(
      title: 'TechEdu Tablets',
      description: 'Providing low-cost learning devices for rural schools.',
      status: 'Funded',
      category: 'Education',
      raisedAmount: 25000,
      goalAmount: 25000,
      statusLabel: 'Target Reached!',
      statusColor: 'blue',
      imageUrl:
          'https://images.unsplash.com/photo-1544866092-4a8a4e6c1e42?w=400',
    ),
    ProjectModel(
      title: 'Local Park Clean...',
      description: 'Project details incomplete',
      status: 'Draft',
      category: 'Community',
      raisedAmount: 0,
      goalAmount: 0,
      statusLabel: 'Last edited 2h ago',
      statusColor: 'grey',
      imageUrl: '',
      isDraft: true,
    ),
  ];

  List<ProjectModel> get filteredProjects {
    if (selectedFilter == 'All') return projects;
    return projects.where((p) => p.status == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'My Projects',
          style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            decoration: BoxDecoration(
              color: colors.primary800,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: colors.grey0, size: 20.sp),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          12.h.ph,
          Container(
            color: colors.grey0,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChipButton(
                    label: 'All',
                    isSelected: selectedFilter == 'All',
                    onTap: () => setState(() => selectedFilter = 'All'),
                  ),
                  SizedBox(width: 8.w),
                  FilterChipButton(
                    label: 'Open',
                    isSelected: selectedFilter == 'Open',
                    onTap: () => setState(() => selectedFilter = 'Open'),
                  ),
                  SizedBox(width: 8.w),
                  FilterChipButton(
                    label: 'Funded',
                    isSelected: selectedFilter == 'Funded',
                    onTap: () => setState(() => selectedFilter = 'Funded'),
                  ),
                  SizedBox(width: 8.w),
                  FilterChipButton(
                    label: 'Draft',
                    isSelected: selectedFilter == 'Draft',
                    onTap: () => setState(() => selectedFilter = 'Draft'),
                  ),
                ],
              ),
            ),
          ),

          // Projects List
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: filteredProjects.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                return ProjectCard(project: filteredProjects[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
