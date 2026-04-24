import 'package:animate_do/animate_do.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/project_details/project_details_cubit.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/project_details/project_details_state.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/description_section.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/funding_section.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/hero_header.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/stats_row.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/timeline_section.dart';
import '../widgets/background_decoration.dart';
import 'update_project_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final int projectId;

  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectDetailsCubit>().getProject(widget.projectId);
  }

  void _onEditPressed(ProjectModel project) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UpdateProjectScreen(project: project)),
    ).then((_) {
      // Refresh details after returning from edit screen
      context.read<ProjectDetailsCubit>().getProject(widget.projectId);
    });
  }

  void _onDeletePressed(ProjectModel project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Project',
          style: TextStyle(
            color: context.customAppColors.primary900,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${project.name}"? This action cannot be undone.',
          style: TextStyle(
            color: context.customAppColors.neutral700,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: TextStyle(color: context.customAppColors.grey600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: call your delete cubit/repo here
              // e.g. context.read<DeleteProjectCubit>().deleteProject(project.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.customAppColors.error500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customAppColors.grey50,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.customAppColors.grey0,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF4A90E2).withValues(alpha: .15),
              ),
              boxShadow: [
                BoxShadow(
                  color: context.customAppColors.primary600.withValues(
                    alpha: .12,
                  ),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: context.customAppColors.primary900,
                size: 18,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            'Project Details',
            style: TextStyle(
              color: context.customAppColors.primary900,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<ProjectDetailsCubit, ProjectDetailsState>(
            builder: (context, state) {
              return state.maybeWhen(
                success: (project) => FadeInRight(
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      // Edit Button
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: context.customAppColors.grey0,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(
                              0xFF4A90E2,
                            ).withValues(alpha: .15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.customAppColors.primary600
                                  .withValues(alpha: .12),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: context.customAppColors.primary600,
                            size: 18,
                          ),
                          onPressed: () => _onEditPressed(project),
                          tooltip: 'Edit Project',
                        ),
                      ),
                      // Delete Button
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: context.customAppColors.grey0,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: context.customAppColors.error500.withValues(
                              alpha: .2,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.customAppColors.error500
                                  .withValues(alpha: .1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: context.customAppColors.error500,
                            size: 18,
                          ),
                          onPressed: () => _onDeletePressed(project),
                          tooltip: 'Delete Project',
                        ),
                      ),
                    ],
                  ),
                ),
                orElse: () => const SizedBox(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProjectDetailsCubit, ProjectDetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox(),
            loading: () => _buildLoading(),
            success: (project) => _buildSuccess(project),
            error: (message) => _buildError(message),
          );
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              context.customAppColors.primary600,
            ),
            strokeWidth: 2.5,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading project...',
            style: TextStyle(
              color: context.customAppColors.grey600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: FadeInUp(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.customAppColors.error500.withValues(alpha: .08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: context.customAppColors.error500,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: context.customAppColors.neutral700,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(ProjectModel project) {
    return Stack(
      children: [
        BackgroundDecoration(),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 70,
            bottom: 32,
          ),
          child: Column(
            children: [
              HeroHeader(project: project),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    StatsRow(project: project),
                    const SizedBox(height: 20),
                    _AnimatedSection(
                      delay: 200,
                      child: DescriptionSection(project: project),
                    ),
                    const SizedBox(height: 16),
                    _AnimatedSection(
                      delay: 350,
                      child: FundingSection(project: project),
                    ),
                    const SizedBox(height: 16),
                    _AnimatedSection(
                      delay: 500,
                      child: TimelineSection(project: project),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnimatedSection extends StatelessWidget {
  final Widget child;
  final int delay;

  const _AnimatedSection({required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      duration: const Duration(milliseconds: 500),
      child: child,
    );
  }
}
