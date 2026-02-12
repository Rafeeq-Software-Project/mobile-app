import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';
import 'package:rafeeq_app/features/chat/presentation/screens/conversations_screen.dart';
import 'package:rafeeq_app/features/investor_apply_project/presentation/screens/applied_projects_screen.dart';
import 'package:rafeeq_app/features/investor_explore_projects/presentation/screens/explore_projects_screen.dart';
import 'package:rafeeq_app/features/investor_home/presentation/screens/investor_home_screen.dart';
import 'package:rafeeq_app/features/investor_profile/presentation/screens/investor_profile_screen.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/manager/nav_bar_investor_cubit/nav_bar_investor_cubit.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/manager/nav_bar_investor_cubit/nav_bar_investor_state.dart';
import 'package:rafeeq_app/generated/l10n.dart';

class BottomNavBarInvestor extends StatelessWidget {
  BottomNavBarInvestor({super.key});

  final List<Widget> views = [
    InvestorHomeScreen(),
    ExploreProjectsScreen(),
    AppliedProjectsScreen(),
    ConversationsScreen(),
    InvestorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarInvestorCubit, NavBarInvestorState>(
      builder: (context, state) {
        final cubit = context.read<NavBarInvestorCubit>();

        return Scaffold(
          backgroundColor: context.customAppColors.background,
          body: SafeArea(child: views[cubit.selectIndex]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.selectIndex,
            onTap: cubit.changeCurrentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: context.customAppColors.grey0,
            selectedItemColor: context.customAppColors.primary800,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 10.sp,
            unselectedFontSize: 10.sp,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.homeInactive,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    cubit.selectIndex == 0
                        ? context.customAppColors.primary800
                        : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: S.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.teacherInactive,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    cubit.selectIndex == 1
                        ? context.customAppColors.primary800
                        : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: S.of(context).projects,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.teacherInactive,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    cubit.selectIndex == 2
                        ? context.customAppColors.primary800
                        : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: S.of(context).applications,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.massegeIcon,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    cubit.selectIndex == 3
                        ? context.customAppColors.primary800
                        : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: S.of(context).chat,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.personIcon,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    cubit.selectIndex == 4
                        ? context.customAppColors.primary800
                        : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: S.of(context).settings,
              ),
            ],
          ),
        );
      },
    );
  }
}
