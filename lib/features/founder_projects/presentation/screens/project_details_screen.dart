import 'package:animate_do/animate_do.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/project_details/project_details_cubit.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/project_details/project_details_state.dart';

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
      backgroundColor: Color(0xFFF0F8FF),
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
        _BackgroundDecoration(),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 70,
            bottom: 32,
          ),
          child: Column(
            children: [
              _HeroHeader(project: project),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _StatsRow(project: project),
                    const SizedBox(height: 20),
                    _AnimatedSection(
                      delay: 200,
                      child: _DescriptionSection(project: project),
                    ),
                    const SizedBox(height: 16),
                    _AnimatedSection(
                      delay: 350,
                      child: _FundingSection(project: project),
                    ),
                    const SizedBox(height: 16),
                    _AnimatedSection(
                      delay: 500,
                      child: _TimelineSection(project: project),
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

// ─── Background Decoration ───────────────────────────────────────────────────

class _BackgroundDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top-right soft blue orb
        Positioned(
          top: -80,
          right: -80,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  context.customAppColors.primary600.withValues(alpha: 0.18),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Bottom-left lighter blue orb
        Positioned(
          bottom: 100,
          left: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  context.customAppColors.primary400.withValues(alpha: 0.14),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Hero Header ─────────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  final ProjectModel project;

  const _HeroHeader({required this.project});

  Color _statusColor(String status, BuildContext context) {
    switch (status.toLowerCase()) {
      case 'active':
        return context.customAppColors.primary500;
      case 'completed':
        return context.customAppColors.primary600;
      case 'pending':
        return context.customAppColors.warning500;
      default:
        return const Color(0xFF9E9E9E); // grey500
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(project.status, context);

    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          // Deep blue gradient hero card – white text stays readable
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.customAppColors.primary900, Color(0xFF2C5AA0)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          boxShadow: [
            BoxShadow(
              color: context.customAppColors.primary900.withValues(alpha: 0.28),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Founder avatar
                BounceInLeft(
                  delay: const Duration(milliseconds: 200),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          context.customAppColors.primary600,
                          context.customAppColors.primary900,
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .3),
                        width: 2,
                      ),
                    ),
                    child: project.founderProfilePicture != null
                        ? ClipOval(
                            child: Image.network(
                              project.founderProfilePicture!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 26,
                          ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: FadeInRight(
                    delay: const Duration(milliseconds: 300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.founderName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          project.founderCompany ?? 'Independent',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeInRight(
                  delay: const Duration(milliseconds: 400),
                  child: _StatusBadge(
                    status: project.status,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: const Text(
                // project.name used at runtime
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  height: 1.25,
                ),
              ),
            ),
            // NOTE: Replace the empty Text above with project.name at runtime
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: Text(
                project.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  height: 1.25,
                ),
              ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _CategoryChip(category: project.category),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;

  const _StatusBadge({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.category_outlined,
            color: Colors.white.withValues(alpha: 0.85),
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            category,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stats Row ───────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final ProjectModel project;

  const _StatsRow({required this.project});

  @override
  Widget build(BuildContext context) {
    final duration = project.endDate.difference(project.startDate).inDays;

    return Row(
      children: [
        Expanded(
          child: FadeInLeft(
            delay: const Duration(milliseconds: 150),
            child: _StatCard(
              icon: Icons.attach_money_rounded,
              label: 'Funding Goal',
              value: '\$${_formatAmount(project.fundingGoal)}',
              color: context.customAppColors.primary600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: _StatCard(
              icon: Icons.calendar_today_rounded,
              label: 'Duration',
              value: '$duration days',
              color: context.customAppColors.warning500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FadeInRight(
            delay: const Duration(milliseconds: 250),
            child: _StatCard(
              icon: Icons.rocket_launch_rounded,
              label: 'Status',
              value: project.status,
              color: context.customAppColors.primary800,
            ),
          ),
        ),
      ],
    );
  }

  String _formatAmount(num amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return amount.toString();
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.customAppColors.grey0,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.14)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: context.customAppColors.primary900,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: context.customAppColors.grey500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Animated Section Wrapper ─────────────────────────────────────────────────

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

// ─── Card Base ────────────────────────────────────────────────────────────────

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.customAppColors.grey0,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF4A90E2).withValues(alpha: .15)),
        boxShadow: [
          BoxShadow(
            color: context.customAppColors.primary600.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _SectionTitle({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: context.customAppColors.primary900,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

// ─── Description Section ──────────────────────────────────────────────────────

class _DescriptionSection extends StatefulWidget {
  final ProjectModel project;

  const _DescriptionSection({required this.project});

  @override
  State<_DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<_DescriptionSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.project.description;
    final isLong = text.length > 180;

    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: 'About the Project',
            icon: Icons.info_outline_rounded,
            color: context.customAppColors.primary800,
          ),
          const SizedBox(height: 14),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _expanded || !isLong
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.customAppColors.neutral700,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            secondChild: Text(
              text,
              style: TextStyle(
                color: context.customAppColors.neutral700,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
          if (isLong) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Text(
                _expanded ? 'Show less' : 'Read more',
                style: TextStyle(
                  color: context.customAppColors.primary600,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Funding Section ──────────────────────────────────────────────────────────

class _FundingSection extends StatelessWidget {
  final ProjectModel project;

  const _FundingSection({required this.project});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: 'Funding',
            icon: Icons.account_balance_wallet_outlined,
            color: context.customAppColors.primary600,
          ),
          const SizedBox(height: 18),
          // Funding Goal Display
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.customAppColors.primary600.withValues(alpha: 0.08),
                  context.customAppColors.primary400.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: context.customAppColors.primary600.withValues(
                  alpha: .18,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.flag_rounded,
                  color: context.customAppColors.primary600,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Funding Goal',
                      style: TextStyle(
                        color: context.customAppColors.grey500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${project.fundingGoal.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: context.customAppColors.primary600,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Use of Funds',
            style: TextStyle(
              color: context.customAppColors.grey500,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project.useOfFunds,
            style: TextStyle(
              color: context.customAppColors.neutral700,
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Timeline Section ─────────────────────────────────────────────────────────

class _TimelineSection extends StatelessWidget {
  final ProjectModel project;

  const _TimelineSection({required this.project});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            title: 'Timeline',
            icon: Icons.timeline_rounded,
            color: context.customAppColors.warning500,
          ),
          const SizedBox(height: 18),
          _TimelineTile(
            icon: Icons.play_circle_outline_rounded,
            label: 'Start Date',
            date: project.startDate,
            color: context.customAppColors.primary500, // bright blue
            isFirst: true,
          ),
          _TimelineTile(
            icon: Icons.stop_circle_outlined,
            label: 'End Date',
            date: project.endDate,
            color: context.customAppColors.error500, // red
          ),
          _TimelineTile(
            icon: Icons.add_circle_outline_rounded,
            label: 'Created At',
            date: project.createdAt,
            color: context.customAppColors.info300, // soft purple
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final DateTime date;
  final Color color;
  final bool isFirst;
  final bool isLast;

  const _TimelineTile({
    required this.icon,
    required this.label,
    required this.date,
    required this.color,
    this.isFirst = false,
    this.isLast = false,
  });

  String _formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]}, ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        width: 1.5,
                        color: context.customAppColors.primary600.withValues(
                          alpha: .18,
                        ),
                      ),
                    ),
                  ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .10),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color.withValues(alpha: .30),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                if (!isLast)
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        width: 1.5,
                        color: context.customAppColors.primary600.withValues(
                          alpha: 0.18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: context.customAppColors.grey600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    _formatDate(date.toLocal()),
                    style: TextStyle(
                      color: context.customAppColors.primary900,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
