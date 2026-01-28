import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/generated/l10n.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.customAppColors.primary800;

    return Scaffold(
      backgroundColor: context.customAppColors.background,
      appBar: AppBar(
        backgroundColor: context.customAppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).termsScreenTitle,
          style: AppTextStyles.font18Bold.copyWith(
            color: context.customAppColors.grey900,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            height: 1.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withValues(alpha: 0.1),
                  primaryColor.withValues(alpha: 0.3),
                  primaryColor.withValues(alpha: 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withValues(alpha: 0.8)],
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  // Image.asset(
                  //   AppImages.imagesMasterLightLogo,
                  //   height: 80.r,
                  //   width: 80.r,
                  // ),
                  SizedBox(height: 16.h),
                  Text(
                    S.of(context).platformName,
                    style: AppTextStyles.font20Regular.copyWith(
                      color: context.customAppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    S.of(context).termsScreenSubtitle,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: context.customAppColors.white.withValues(
                        alpha: 0.9,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildExpandableSection(
                  context: context,
                  index: 0,
                  title: S.of(context).termsIntroSectionTitle,
                  content: S.of(context).termsIntroSectionContent,
                  icon: Icons.info_outline_rounded,
                  iconColor: context.customAppColors.primary800,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 1,
                  title: S.of(context).userResponsibilitiesTitle,
                  content: S.of(context).userResponsibilitiesContent,
                  icon: Icons.account_circle_outlined,
                  iconColor: context.customAppColors.info700,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 2,
                  title: S.of(context).privacyAndDataTitle,
                  content: S.of(context).privacyAndDataContent,
                  icon: Icons.privacy_tip_outlined,
                  iconColor: context.customAppColors.warning500,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 3,
                  title: S.of(context).projectsAndInvestmentsTitle,
                  content: S.of(context).projectsAndInvestmentsContent,
                  icon: Icons.work_outline,
                  iconColor: context.customAppColors.error700,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 4,
                  title: S.of(context).informationAccuracyTitle,
                  content: S.of(context).informationAccuracyContent,
                  icon: Icons.fact_check_outlined,
                  iconColor: context.customAppColors.primary500,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 5,
                  title: S.of(context).liabilityLimitationTitle,
                  content: S.of(context).liabilityLimitationContent,
                  icon: Icons.gavel_rounded,
                  iconColor: context.customAppColors.error900,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 6,
                  title: S.of(context).intellectualPropertyTitle,
                  content: S.of(context).intellectualPropertyContent,
                  icon: Icons.copyright_outlined,
                  iconColor: context.customAppColors.info300,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 7,
                  title: S.of(context).accountTerminationTitle,
                  content: S.of(context).accountTerminationContent,
                  icon: Icons.block_outlined,
                  iconColor: context.customAppColors.info900,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 8,
                  title: S.of(context).termsUpdatesTitle,
                  content: S.of(context).termsUpdatesContent,
                  icon: Icons.update_outlined,
                  iconColor: context.customAppColors.accent700,
                ),
                _sectionGap(),
                _buildExpandableSection(
                  context: context,
                  index: 9,
                  title: S.of(context).supportAndContactTitle,
                  content: S.of(context).supportAndContactContent,
                  icon: Icons.contact_support_outlined,
                  iconColor: context.customAppColors.accent600,
                ),
              ]),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: context.customAppColors.grey0,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Text(
                    S.of(context).termsLastUpdateLabel,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: context.customAppColors.grey600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    S.of(context).termsAcceptanceNote,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: context.customAppColors.grey600,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionGap() => SizedBox(height: 12.h);

  Widget _buildExpandableSection({
    required BuildContext context,
    required int index,
    required String title,
    required String content,
    required IconData icon,
    required Color iconColor,
  }) {
    final isExpanded = _expandedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: context.customAppColors.grey0,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isExpanded
              ? iconColor.withValues(alpha: 0.5)
              : context.customAppColors.grey200,
          width: isExpanded ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isExpanded
                ? iconColor.withValues(alpha: 0.15)
                : context.customAppColors.grey100,
            blurRadius: isExpanded ? 16 : 8,
            offset: Offset(0, isExpanded ? 6 : 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _expandedIndex = isExpanded ? null : index;
              });
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(18.w),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: iconColor.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(icon, color: iconColor, size: 22.sp),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.font16SemiBold.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: isExpanded ? 0.5 : 0,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 24.sp,
                          color: iconColor,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1.h,
                          margin: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                iconColor.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Text(
                          content,
                          style: AppTextStyles.font14Regular.copyWith(
                            color: context.customAppColors.grey700,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
