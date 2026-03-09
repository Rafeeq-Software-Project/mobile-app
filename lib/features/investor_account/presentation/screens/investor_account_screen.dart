import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/my_investor_profile/my_investor_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/my_investor_profile/my_investor_profile_state.dart';
import 'package:rafeeq_app/features/investor_account/presentation/widgets/investor_account_widgets.dart';

class InvestorAccountScreen extends StatefulWidget {
  const InvestorAccountScreen({super.key});

  @override
  State<InvestorAccountScreen> createState() => _InvestorAccountScreenState();
}

class _InvestorAccountScreenState extends State<InvestorAccountScreen> {
  String selectedTab = 'Interests';

  @override
  void initState() {
    super.initState();
  }

  void _onTabChanged(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return BlocBuilder<MyInvestorProfileCubit, MyInvestorProfileState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            return SizedBox.shrink();
          },
          loading: () {
            return Scaffold(
              backgroundColor: context.customAppColors.grey0,
              body: const Center(child: CustomLoading(size: 100)),
            );
          },
          loaded: (InvestorProfileModel profile) {
            return Scaffold(
              backgroundColor: colors.grey0,
              body: SafeArea(
                child: Column(
                  children: [
                    // App Bar
                    ProfileAppBar(
                      onBackTap: () => Navigator.pop(context),
                      onEditTap: () {},
                    ),

                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),

                            // Profile Header
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: ProfileHeaderCard(
                                name: profile.userFirstName,
                                title: profile.stage ?? 'No Bio',
                                location: profile.location ?? ' No Location',
                                imageUrl: profile.userProfilePictureUrl ?? '',
                                isVerified: true,
                                bio: profile.bio ?? '',
                              ),
                            ),
                            SizedBox(height: 20.h),

                            SizedBox(height: 24.h),

                            // Tabs
                            ProfileTabs(
                              selectedTab: selectedTab,
                              onTabChanged: _onTabChanged,
                            ),
                            SizedBox(height: 20.h),

                            // Content based on selected tab
                            if (selectedTab == 'Interests')
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: FocusAreasGrid(
                                  focusAreas: profile.investmentInterests ?? [],
                                ),
                              ),
                            if (selectedTab == 'Portfolio')
                              if (selectedTab == 'Reviews')
                                Padding(
                                  padding: EdgeInsets.all(40.w),
                                  child: Text(
                                    'No reviews yet',
                                    style: AppTextStyles.font14Regular.copyWith(
                                      color: colors.grey500,
                                    ),
                                  ),
                                ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (String message) {
            return Scaffold(
              backgroundColor: context.customAppColors.grey0,
              body: Center(child: Text('Error loading profile: $message')),
            );
          },
        );
      },
    );
  }
}
