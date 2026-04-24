import 'package:animate_do/animate_do.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/create_project/presentation/logic/delete_project/delete_project_cubit.dart';
import 'package:rafeeq_app/features/create_project/presentation/logic/delete_project/delete_project_state.dart';
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
      if (!mounted) return;
      context.read<ProjectDetailsCubit>().getProject(widget.projectId);
    });
  }

  void _onDeletePressed(ProjectModel project) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Delete Dialog',
      barrierColor: Colors.black.withValues(alpha: .5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => BlocProvider.value(
        value: context.read<DeleteProjectCubit>(),
        child: _DeleteConfirmDialog(project: project),
      ),
      transitionBuilder: (_, anim, __, child) {
        final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1.0).animate(curved),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
            child: child,
          ),
        );
      },
    ).then((deleted) {
      if (!mounted) return;
      if (deleted == true) Navigator.pop(context);
    });
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

class _DeleteConfirmDialog extends StatefulWidget {
  final ProjectModel project;
  const _DeleteConfirmDialog({required this.project});

  @override
  State<_DeleteConfirmDialog> createState() => _DeleteConfirmDialogState();
}

class _DeleteConfirmDialogState extends State<_DeleteConfirmDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
        );

    // auto-play shake on open
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _shakeController.forward();
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return BlocListener<DeleteProjectCubit, DeleteProjectState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message) {
            Navigator.of(context).pop(true); // true = deleted
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: colors.primary600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
          error: (error) {
            Navigator.of(context).pop(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: colors.error500,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        );
      },
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: colors.grey0,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: colors.error500.withValues(alpha: .15),
                  blurRadius: 40,
                  spreadRadius: 4,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colors.error500,
                        colors.error500.withValues(alpha: .4),
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                  child: Column(
                    children: [
                      // ── Shake icon ──
                      AnimatedBuilder(
                        animation: _shakeAnim,
                        builder: (_, child) => Transform.translate(
                          offset: Offset(_shakeAnim.value, 0),
                          child: child,
                        ),
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                colors.error500.withValues(alpha: .15),
                                colors.error500.withValues(alpha: .05),
                              ],
                            ),
                            border: Border.all(
                              color: colors.error500.withValues(alpha: .2),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.delete_forever_rounded,
                            color: colors.error500,
                            size: 32,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Title ──
                      Text(
                        'Delete Project?',
                        style: TextStyle(
                          color: colors.primary800,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // ── Project name badge ──
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: colors.grey100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: colors.grey200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.folder_outlined,
                              size: 14,
                              color: colors.grey600,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                widget.project.name,
                                style: TextStyle(
                                  color: colors.grey700,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ── Warning text ──
                      Text(
                        'This action is permanent and cannot be undone. All project data will be lost.',
                        style: TextStyle(
                          color: colors.grey500,
                          fontSize: 13,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),

                      // ── Buttons ──
                      BlocBuilder<DeleteProjectCubit, DeleteProjectState>(
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          );
                          return Row(
                            children: [
                              // Cancel
                              Expanded(
                                child: TextButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => Navigator.of(context).pop(false),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      side: BorderSide(color: colors.grey200),
                                    ),
                                    backgroundColor: colors.grey50,
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: colors.grey700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Delete
                              Expanded(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    gradient: isLoading
                                        ? null
                                        : LinearGradient(
                                            colors: [
                                              colors.error500,
                                              Color.lerp(
                                                colors.error500,
                                                Colors.black,
                                                .15,
                                              )!,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                    color: isLoading
                                        ? colors.error500.withValues(alpha: .5)
                                        : null,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: isLoading
                                        ? []
                                        : [
                                            BoxShadow(
                                              color: colors.error500.withValues(
                                                alpha: .4,
                                              ),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            _shakeController
                                              ..reset()
                                              ..forward();
                                            context
                                                .read<DeleteProjectCubit>()
                                                .deleteProject(
                                                  widget.project.id,
                                                );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      disabledBackgroundColor:
                                          Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.delete_rounded,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
