import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_account/presentation/widgets/profile_info_section.dart';
import 'package:rafeeq_app/features/founder_profile/data/models/founder_profile.dart';
import 'package:rafeeq_app/features/founder_profile/presentation/logic/cubit/founder_profile_cubit.dart';
import 'package:rafeeq_app/features/founder_profile/presentation/logic/cubit/founder_profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/about_section.dart';
import '../widgets/action_buttons_row.dart';

class FounderAccountScreen extends StatefulWidget {
  const FounderAccountScreen({super.key});

  @override
  State<FounderAccountScreen> createState() => _FounderAccountScreenState();
}

class _FounderAccountScreenState extends State<FounderAccountScreen> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    context.read<FounderProfileCubit>().fetchFounderProfile();
  }

  void _shareProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile link copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.customAppColors.accent600,
      ),
    );
  }

  void _createNewProject() {
    GoRouter.of(context).push(Routes.createProjectSteps);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return BlocBuilder<FounderProfileCubit, FounderProfileState>(
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
          loaded: (FounderProfile profile) {
            return Scaffold(
              backgroundColor: colors.grey0,
              body: CustomScrollView(
                slivers: [
                  // App Bar
                  SliverAppBar(
                    backgroundColor: colors.grey0,
                    elevation: 0,
                    pinned: false,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: colors.grey900),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Text(
                      'My Profile',
                      style: AppTextStyles.font18Bold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          color: colors.grey900,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.edit_outlined, color: colors.grey900),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  // Content
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          color: colors.grey0,
                          child: ProfileHeader(founderProfile: profile),
                        ),
                        AboutSection(
                          aboutMe: profile.bio ?? 'Not provided',
                          role: profile.roleTitle ?? "Not provided",
                          industry: profile.industry ?? 'Not provided',
                          company: profile.companyName ?? 'Not provided',
                        ),
                        ProfileInfoSection(profile: profile),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: ActionButtonsRow(
                onShare: _shareProfile,
                onNewProject: _createNewProject,
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
