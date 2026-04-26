import 'package:flutter_animate/flutter_animate.dart';
import 'package:rafeeq_app/core/common/widgets/custom_not_found.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/get_projects/get_projects_cubit.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/get_projects/get_projects_state.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/filter_bar.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/project_card.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/project_card_shimmer.dart';

class MyProjectsScreen extends StatefulWidget {
  const MyProjectsScreen({super.key});

  @override
  State<MyProjectsScreen> createState() => _MyProjectsScreenState();
}

class _MyProjectsScreenState extends State<MyProjectsScreen>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = 'All';
  late final AnimationController _fabController;

  static const _filters = ['All', 'Approved', 'Rejected', 'Pending'];

  List<ProjectModel> _filterProjects(List<ProjectModel> projects) {
    if (_selectedFilter == 'All') return projects;
    return projects.where((p) => p.status == _selectedFilter).toList();
  }

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: true,
        title:
            Text(
                  'My Projects',
                  style: AppTextStyles.font18Bold.copyWith(
                    color: colors.grey900,
                  ),
                )
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(
                  begin: -0.3,
                  end: 0,
                  duration: 400.ms,
                  curve: Curves.easeOut,
                ),
      ),

      body: Column(
        children: [
          FilterBar(
            filters: _filters,
            selected: _selectedFilter,
            onSelected: (f) => setState(() => _selectedFilter = f),
            colors: colors,
          ),
          Expanded(
            child: BlocBuilder<GetProjectsCubit, GetProjectsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),

                  loading: () => ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: 5,
                    itemBuilder: (_, i) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: const ProjectCardShimmer()
                          .animate(delay: (i * 80).ms)
                          .fadeIn(duration: 400.ms),
                    ),
                  ),

                  success: (projects) {
                    final filtered = _filterProjects(projects);
                    if (filtered.isEmpty) {
                      return const CustomNotFound()
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .scale(
                            begin: const Offset(0.85, 0.85),
                            end: const Offset(1, 1),
                            duration: 500.ms,
                            curve: Curves.easeOut,
                          );
                    }
                    return _AnimatedProjectList(
                      projects: filtered,
                      key: ValueKey(_selectedFilter),
                    );
                  },

                  error: (msg) => Center(
                    child: Text(
                      msg,
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.grey600,
                      ),
                    ).animate().fadeIn(),
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

class _AnimatedProjectList extends StatelessWidget {
  final List<ProjectModel> projects;

  const _AnimatedProjectList({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: AnimatedProjectCard(project: projects[index], index: index),
        );
      },
    );
  }
}

Color statusColor(String status, dynamic colors) {
  switch (status.toLowerCase()) {
    case 'approved':
      return colors.accent600;
    case 'rejected':
      return colors.warning500;
    case 'pending':
      return colors.primary800;
    default:
      return colors.grey500;
  }
}

Color statusBg(String status, dynamic colors) {
  switch (status.toLowerCase()) {
    case 'approved':
      return colors.accent600.withValues(alpha: .12);
    case 'rejected':
      return colors.warning500.withValues(alpha: .12);
    case 'pending':
      return colors.primary800.withValues(alpha: .10);
    default:
      return colors.grey100;
  }
}
