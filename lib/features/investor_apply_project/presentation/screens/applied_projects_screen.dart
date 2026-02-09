import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_apply_project/data/models/application_model.dart';
import 'package:rafeeq_app/features/investor_apply_project/presentation/widgets/applied_widgets.dart';

class AppliedProjectsScreen extends StatefulWidget {
  const AppliedProjectsScreen({super.key});

  @override
  State<AppliedProjectsScreen> createState() => _AppliedProjectsScreenState();
}

class _AppliedProjectsScreenState extends State<AppliedProjectsScreen> {
  List<ApplicationModel> applications = [];
  String selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    _loadApplications();
  }

  void _loadApplications() {
    setState(() {
      applications = ApplicationModel.getSampleApplications();
    });
  }

  List<ApplicationModel> get filteredApplications {
    if (selectedStatus == 'All') {
      return applications;
    }
    return applications.where((app) => app.status == selectedStatus).toList();
  }

  void _onStatusChanged(String status) {
    setState(() {
      selectedStatus = status;
    });
  }

  double get totalInvested {
    return applications
        .where((app) => app.status == 'Approved')
        .fold(0.0, (sum, app) => sum + app.proposedAmount);
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
            AppliedAppBar(
              onBackTap: () => Navigator.pop(context),
              onFilterTap: () {},
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Status Filter Tabs
                    StatusFilterTabs(
                      selectedStatus: selectedStatus,
                      onStatusChanged: _onStatusChanged,
                    ),
                    SizedBox(height: 20.h),

                    // Investment Summary Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: InvestmentSummaryCard(
                        totalInvested: totalInvested,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Applications List
                    Container(
                      color: colors.grey0,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: filteredApplications.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: colors.grey200,
                          indent: 20.w,
                          endIndent: 20.w,
                        ),
                        itemBuilder: (context, index) {
                          return ApplicationListItem(
                            application: filteredApplications[index],
                            onTap: () {},
                          );
                        },
                      ),
                    ),
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
