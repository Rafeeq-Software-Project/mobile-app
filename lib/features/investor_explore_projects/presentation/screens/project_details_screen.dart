import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_explore_projects/data/models/explore_project_model.dart';
import '../widgets/detail_app_bar.dart';
import '../widgets/project_header_image.dart';
import '../widgets/project_info_section.dart';
import '../widgets/pitch_section.dart';
import '../widgets/founder_section.dart';
import '../widgets/deal_highlights_section.dart';
import '../widgets/due_diligence_section.dart';
import '../widgets/apply_button.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  late ProjectDetailModel projectDetail;

  @override
  void initState() {
    super.initState();
    projectDetail = ProjectDetailModel.sample();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.grey0,
      body: Stack(
        children: [
          // Content
          CustomScrollView(
            slivers: [
              // App Bar
              DetailAppBar(
                onBackTap: () => Navigator.pop(context),
                onShareTap: () {},
              ),

              // Scrollable Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Image
                    ProjectHeaderImage(
                      imageUrl: projectDetail.imageUrl,
                      stage: projectDetail.stage,
                    ),
                    SizedBox(height: 16.h),

                    // Project Info
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ProjectInfoSection(
                        title: projectDetail.title,
                        tagline: projectDetail.tagline,
                        category: projectDetail.category,
                        location: projectDetail.location,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Funding Info
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: colors.grey50,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: colors.grey200),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RAISED',
                                    style: AppTextStyles.font12Bold.copyWith(
                                      color: colors.grey600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '\$${projectDetail.fundingAmount.toStringAsFixed(0)}',
                                    style: AppTextStyles.font20Bold.copyWith(
                                      color: colors.accent600,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    projectDetail.fundingDuration,
                                    style: AppTextStyles.font12Regular.copyWith(
                                      color: colors.grey600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 40.h,
                              color: colors.grey300,
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people_outline,
                                        size: 16.sp,
                                        color: colors.grey600,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        '${projectDetail.teamSize} Investors',
                                        style: AppTextStyles.font12Regular
                                            .copyWith(color: colors.grey700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_outlined,
                                        size: 16.sp,
                                        color: colors.grey600,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        projectDetail.deadline,
                                        style: AppTextStyles.font12Regular
                                            .copyWith(color: colors.grey700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // The Pitch
                    PitchSection(pitch: projectDetail.pitch),
                    SizedBox(height: 24.h),

                    // Meet the Founder
                    FounderSection(founder: projectDetail.founder),
                    SizedBox(height: 24.h),

                    // Deal Highlights
                    DealHighlightsSection(
                      highlights: projectDetail.dealHighlights,
                    ),
                    SizedBox(height: 24.h),

                    // Due Diligence
                    DueDiligenceSection(documents: projectDetail.documents),
                    SizedBox(height: 100.h), // Space for button
                  ],
                ),
              ),
            ],
          ),

          // Floating Apply Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ApplyButton(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Application submitted!'),
                    backgroundColor: colors.accent600,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
