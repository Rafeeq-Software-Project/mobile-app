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
                color: Color(0xFF4A90E2).withValues(alpha: .15),
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
