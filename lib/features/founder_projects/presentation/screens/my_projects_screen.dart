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

  void _onFabTap() {
    _fabController.forward().then((_) => _fabController.reverse());
    GoRouter.of(context).push(Routes.createProjectSteps);
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: _AnimatedFab(
              controller: _fabController,
              color: colors.primary800,
              iconColor: colors.grey0,
              onTap: _onFabTap,
            ),
          ),
        ],
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

class _AnimatedFab extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _AnimatedFab({
    required this.controller,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rotation = Tween<double>(
      begin: 0,
      end: 0.375,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    final scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.1), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    return GestureDetector(
          onTap: onTap,
          child: AnimatedBuilder(
            animation: controller,
            builder: (_, child) => Transform.scale(
              scale: scale.value,
              child: Transform.rotate(
                angle: rotation.value * 2 * 3.14159,
                child: child,
              ),
            ),
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(Icons.add, color: iconColor, size: 20.sp),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 500.ms, delay: 200.ms)
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: 500.ms,
          delay: 200.ms,
          curve: Curves.elasticOut,
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
