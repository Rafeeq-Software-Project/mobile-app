import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/local_data/current_user.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/founder_home/presentation/widgets/active_projects_section.dart'
    show ActiveProjectsSection;
import 'package:rafeeq_app/features/founder_home/presentation/widgets/dashboard_app_bar.dart';
import 'package:rafeeq_app/features/founder_home/presentation/widgets/quick_actions_section.dart';
import 'package:rafeeq_app/features/founder_home/presentation/widgets/stats_grid.dart';
import 'package:rafeeq_app/features/founder_home/presentation/widgets/welcome_section.dart';

import '../../data/models/dashboard_project_model.dart';
import '../../data/models/stats_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final info = CurrentUser.data;
    // Sample data
    final stats = [
      StatsModel(
        label: 'Active Volunteers',
        value: '247',
        changePercentage: '+12%',
        isPositive: true,
      ),
      StatsModel(
        label: 'Active Projects',
        value: '8',
        changePercentage: '+2',
        isPositive: true,
      ),
      StatsModel(
        label: 'Total Hours',
        value: '1,42',
        changePercentage: '+8%',
        isPositive: true,
      ),
      StatsModel(
        label: 'Completion Rate',
        value: '94%',
        changePercentage: '3%',
        isPositive: true,
        isHighlighted: true,
      ),
    ];

    final activeProjects = [
      DashboardProjectModel(
        title: 'AI Literacy Workshop',
        volunteers: 12,
        dueDate: 'Oct 24',
        status: 'IN PROGRESS',
        statusColor: 'blue',
        progress: 0.65,
      ),
      DashboardProjectModel(
        title: 'Market Research Q4',
        volunteers: 8,
        dueDate: 'Nov 02',
        status: 'IN PROGRESS',
        statusColor: 'blue',
        progress: 0.45,
      ),
      DashboardProjectModel(
        title: 'Branding Refresh',
        volunteers: 0,
        dueDate: '',
        status: 'REVIEW REQUIRED',
        statusColor: 'orange',
        progress: 0.0,
      ),
    ];

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            DashboardAppBar(
              userName: info.firstName,
              onNotificationTap: () {},
              onProfileTap: () {},
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    // Welcome Section
                    WelcomeSection(userName: info.firstName),
                    SizedBox(height: 24.h),

                    // Stats Grid
                    StatsGrid(stats: stats),
                    SizedBox(height: 28.h),

                    // Quick Actions
                    QuickActionsSection(),
                    SizedBox(height: 32.h),

                    // Active Projects
                    ActiveProjectsSection(projects: activeProjects),
                    SizedBox(height: 24.h),
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
