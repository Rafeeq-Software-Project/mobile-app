import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';
import 'package:rafeeq_app/features/chat/presentation/screens/conversations_screen.dart';
import 'package:rafeeq_app/features/founder_profile/presentation/screens/founder_profile_screen.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/screens/my_projects_screen.dart';
import 'package:rafeeq_app/features/nav_bar_founder/presentation/manager/nav_bar_cubit/nav_bar_cubit.dart';
import 'package:rafeeq_app/generated/l10n.dart';

import '../../../investor_applications/presentation/screens/investor_applications_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final List<Widget> views = [
    Container(),
    MyProjectsScreen(),
    InvestorApplicationsScreen(),
    ConversationsScreen(),
    FounderProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          final cubit = context.read<NavBarCubit>();
          return Scaffold(
            backgroundColor: context.customAppColors.background,
            body: SafeArea(child: views[cubit.selectIndex]),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 24.h, right: 8.w, left: 8.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),
                  color: context.customAppColors.grey0,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
                  child: GNav(
                    onTabChange: (index) => cubit.changeCurrentIndex(index),
                    selectedIndex: cubit.selectIndex,
                    tabBorderRadius: 20.r,
                    duration: const Duration(milliseconds: 400),
                    gap: 3.w,
                    color: Colors.grey,
                    activeColor: context.customAppColors.grey0,
                    iconSize: 22.sp,
                    tabBackgroundColor: context.customAppColors.primary800,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    tabs: [
                      GButton(
                        leading: SvgPicture.asset(
                          AppIcons.homeInactive,
                          height: 20.h,
                          width: 18.h,
                          colorFilter: ColorFilter.mode(
                            cubit.selectIndex == 0
                                ? context.customAppColors.grey0
                                : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        text: S.of(context).home,
                        icon: Icons.home,
                      ),
                      GButton(
                        icon: Icons.school,
                        leading: SvgPicture.asset(
                          AppIcons.teacherInactive,
                          colorFilter: ColorFilter.mode(
                            cubit.selectIndex == 1
                                ? context.customAppColors.grey0
                                : Colors.grey,
                            BlendMode.srcIn,
                          ),
                          height: 20.h,
                          width: 18.h,
                        ),
                        text: S.of(context).projects,
                      ),
                      GButton(
                        icon: Icons.school,
                        leading: SvgPicture.asset(
                          AppIcons.teacherInactive,
                          colorFilter: ColorFilter.mode(
                            cubit.selectIndex == 2
                                ? context.customAppColors.grey0
                                : Colors.grey,
                            BlendMode.srcIn,
                          ),
                          height: 20.h,
                          width: 18.h,
                        ),
                        text: S.of(context).applications,
                      ),
                      GButton(
                        icon: Icons.note,
                        leading: SvgPicture.asset(
                          AppIcons.massegeIcon,
                          colorFilter: ColorFilter.mode(
                            cubit.selectIndex == 3
                                ? context.customAppColors.grey0
                                : Colors.grey,
                            BlendMode.srcIn,
                          ),
                          height: 20.h,
                          width: 18.h,
                        ),
                        text: S.of(context).chat,
                      ),
                      GButton(
                        icon: Icons.settings,
                        leading: SvgPicture.asset(
                          AppIcons.personIcon,
                          colorFilter: ColorFilter.mode(
                            cubit.selectIndex == 4
                                ? context.customAppColors.grey0
                                : Colors.grey,
                            BlendMode.srcIn,
                          ),
                          height: 20.h,
                          width: 18.h,
                        ),
                        text: S.of(context).settings,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
