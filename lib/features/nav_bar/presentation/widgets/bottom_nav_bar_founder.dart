import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafeeq_app/core/di/service_locator.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';
import 'package:rafeeq_app/features/chat/presentation/screens/conversations_screen.dart';
import 'package:rafeeq_app/features/founder_home/presentation/screens/founder_home_screen.dart';
import 'package:rafeeq_app/features/founder_profile/presentation/screens/founder_profile_screen.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/get_projects/get_projects_cubit.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/screens/my_projects_screen.dart';
import 'package:rafeeq_app/features/nav_bar/presentation/manager/nav_bar_founder_cubit/nav_bar_founder_cubit.dart';
import 'package:rafeeq_app/generated/l10n.dart';
import '../../../investor_applications/presentation/screens/investor_applications_screen.dart';

class CustomBottomNavBarFounder extends StatelessWidget {
  CustomBottomNavBarFounder({super.key});

  final List<Widget> views = [
    DashboardScreen(),
    BlocProvider(
      create: (_) => getIt<GetProjectsCubit>()..getProjects(),
      child: MyProjectsScreen(),
    ),
    InvestorApplicationsScreen(),
    ConversationsScreen(),
    FounderProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarFounderCubit, NavBarFouderState>(
      builder: (context, state) {
        final cubit = context.read<NavBarFounderCubit>();

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
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.homeInactive,
                  height: 22.h,
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
                  height: 22.h,
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
                  height: 22.h,
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
                  height: 22.h,
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
                  height: 22.h,
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
