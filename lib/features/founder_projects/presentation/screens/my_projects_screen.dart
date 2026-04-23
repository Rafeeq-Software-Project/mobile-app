import 'package:rafeeq_app/core/common/widgets/custom_not_found.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/get_projects/get_projects_cubit.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/get_projects/get_projects_state.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/project_card_shimmer.dart';
import '../widgets/filter_chip_button.dart';
import '../widgets/project_card.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({super.key});

  @override
  State<MyProjectsScreen> createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen> {
  String selectedFilter = 'All';

  List<ProjectModel> filterProjects(List<ProjectModel> projects) {
    if (selectedFilter == 'All') return projects;
    return projects.where((p) => p.status == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'My Projects',
          style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            decoration: BoxDecoration(
              color: colors.primary800,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: colors.grey0, size: 20.sp),
              onPressed: () {
                GoRouter.of(context).push(Routes.createProjectSteps);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          12.h.ph,
          Container(
            color: colors.grey0,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    FilterChipButton(
                      label: 'All',
                      isSelected: selectedFilter == 'All',
                      onTap: () => setState(() => selectedFilter = 'All'),
                    ),
                    SizedBox(width: 8.w),
                    FilterChipButton(
                      label: 'Approved',
                      isSelected: selectedFilter == 'Approved',
                      onTap: () => setState(() => selectedFilter = 'Approved'),
                    ),
                    SizedBox(width: 8.w),
                    FilterChipButton(
                      label: 'Rejected',
                      isSelected: selectedFilter == 'Rejected',
                      onTap: () => setState(() => selectedFilter = 'Rejected'),
                    ),
                    SizedBox(width: 8.w),
                    FilterChipButton(
                      label: 'Pending',
                      isSelected: selectedFilter == 'Pending',
                      onTap: () => setState(() => selectedFilter = 'Pending'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Projects List
          Expanded(
            child: BlocBuilder<GetProjectsCubit, GetProjectsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),

                  loading: () {
                    return ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: const ProjectCardShimmer(),
                        );
                      },
                    );
                  },

                  success: (projects) {
                    final filtered = filterProjects(projects);

                    if (filtered.isEmpty) {
                      return CustomNotFound();
                    }
                    return ListView.separated(
                      padding: EdgeInsets.all(16.w),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        return ProjectCard(project: filtered[index]);
                      },
                    );
                  },

                  error: (message) => Center(child: Text(message)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
