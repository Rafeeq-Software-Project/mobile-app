import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/about_team_bottom_sheet.dart';
import 'package:rafeeq_app/core/common/widgets/snackbar_helper.dart';
import 'package:rafeeq_app/core/common/widgets/theme_bottom_sheet.dart';
import 'package:rafeeq_app/core/helpers/shared_pref_helper.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/founder_profile/presentation/widgets/custom_profile_header.dart';
import '../../../../core/common/widgets/custom_profile_list_tile.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../generated/l10n.dart';

class FounderProfileScreen extends StatefulWidget {
  const FounderProfileScreen({super.key});

  @override
  State<FounderProfileScreen> createState() => _FounderProfileScreenState();
}

class _FounderProfileScreenState extends State<FounderProfileScreen> {
  bool isPushNotificationsEnabled = true;
  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': AppIcons.personIcon,
        'title': S.of(context).editProfile,
        'onTap': () {},
      },
      {
        'icon': AppIcons.themeIcon,
        'title': S.of(context).theme,
        'onTap': () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const ThemeBottomSheet(),
          );
        },
      },
      {
        'icon': AppIcons.iconsFaq,
        'title': S.of(context).FAQChatcentre,
        'onTap': () {
          GoRouter.of(context).push(Routes.popularQuestionsScreen);
        },
      },
      {
        'icon': AppIcons.iconsRate,
        'title': S.of(context).givetheRating,
        'onTap': () {
          SnackbarHelper.showSuccessSnackbar(context, 'التقييم قيد التطوير');
        },
      },
      {
        'icon': AppIcons.iconsTermsConditions,
        'title': S.of(context).termsAndCondition,
        'onTap': () {
          GoRouter.of(context).push(Routes.termsAndConditionScreen);
        },
      },
      {
        'icon': AppIcons.iconsAbout,
        'title': S.of(context).aboutRafeeqteam,
        'onTap': () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AboutTeamBottomSheet(),
          );
        },
      },
      {
        'icon': AppIcons.iconsExit,
        'title': S.of(context).exittheapp,
        'onTap': () async {
          SharedPrefHelper.clearAllData();
          SharedPrefHelper.clearAllSecuredData();
          GoRouter.of(context).pushReplacement(Routes.onboarding);
        },
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.h.ph,
            Container(
              width: double.infinity,
              color: context.customAppColors.background,
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: CustomProfileHeader(
                imageUrl: 'https://example.com/profile.jpg',
                name: 'Ahmed Al-Fayed',
                subtitle: 'Founder & Entrepreneur',
                memberSince: 'Member since 2021',
                isVerified: true,
              ),
            ),

            SizedBox(height: 16.h),
            ...items.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: CustomProfileListTile(
                  iconUrl: item['icon'] as String,
                  title: item['title'] as String,
                  onPressed: item['onTap'] as VoidCallback,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
