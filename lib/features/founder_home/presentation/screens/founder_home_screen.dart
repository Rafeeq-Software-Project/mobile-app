import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/local_data/current_user.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_home/data/models/drafts/pending_draft_model.dart';
import 'package:rafeeq_app/features/founder_home/presentation/logic/all_pending_drafts/pending_drafts_cubit.dart';
import 'package:rafeeq_app/features/founder_home/presentation/logic/all_pending_drafts/pending_drafts_state.dart';
import 'package:rafeeq_app/features/founder_home/presentation/widgets/loading_shimmer.dart';
import '../../data/models/stats_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final info = CurrentUser.data;

    final stats = [
      StatsModel(
        label: 'Active Projects',
        value: '8',
        changePercentage: '+2',
        isPositive: true,
      ),
      StatsModel(
        label: 'Total Funding',
        value: '\$2.4M',
        changePercentage: '+18%',
        isPositive: true,
      ),
      StatsModel(
        label: 'Investors',
        value: '34',
        changePercentage: '+5',
        isPositive: true,
      ),
      StatsModel(
        label: 'Success Rate',
        value: '94%',
        changePercentage: '+3%',
        isPositive: true,
        isHighlighted: true,
      ),
    ];

    return Scaffold(
      backgroundColor: colors.grey50,
      body: Stack(
        children: [
          _BackgroundMesh(controller: _shimmerController),
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _HeroHeader(
                    userName: info.firstName,
                    shimmerController: _shimmerController,
                    scrollOffset: _scrollOffset,
                    colors: colors,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _StatsSection(stats: stats, colors: colors),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: _QuickActions(colors: colors),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: BlocBuilder<PendingDraftsCubit, PendingDraftsState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => SizedBox(),
                          loading: () => Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(7.w),
                                    decoration: BoxDecoration(
                                      color: colors.grey500.withValues(
                                        alpha: .1,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Icon(
                                      Icons.edit_note_rounded,
                                      color: colors.grey500,
                                      size: 16.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Drafts',
                                        style: TextStyle(
                                          color: colors.primary900,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        'Pending submission',
                                        style: TextStyle(
                                          color: colors.grey500,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      GoRouter.of(
                                        context,
                                      ).push(Routes.allDraftsScreen);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.grey500.withValues(
                                          alpha: .08,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        border: Border.all(
                                          color: colors.grey500.withValues(
                                            alpha: .2,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'View all',
                                        style: TextStyle(
                                          color: colors.grey500,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              10.h.ph,
                              LoadingShimmer(colors: colors, isHome: true),
                            ],
                          ),
                          error: (message) => Text(message),
                          success: (drafts) {
                            final displayDrafts = drafts.take(2).toList();
                            return _ProjectsSection(
                              title: 'Drafts',
                              subtitle: 'Pending submission',
                              icon: Icons.edit_note_rounded,
                              projects: displayDrafts,
                              colors: colors,
                              accentColor: colors.grey500,
                              isDraft: true,
                              onTap: (projectId) {
                                // ✅ FIX: using projectId correctly
                                GoRouter.of(context).push(
                                  Routes.draftsDetailsScreen,
                                  extra: projectId,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 100.h)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundMesh extends StatelessWidget {
  final AnimationController controller;
  const _BackgroundMesh({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => CustomPaint(
        painter: _MeshPainter(controller.value, colors.primary800),
        size: Size.infinite,
      ),
    );
  }
}

class _MeshPainter extends CustomPainter {
  final double t;
  final Color primary;
  _MeshPainter(this.t, this.primary);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF4F7FF),
    );

    final o1x = size.width * 0.9 + math.sin(t * 2 * math.pi) * 15;
    final o1y = size.height * 0.04 + math.cos(t * 2 * math.pi) * 10;
    canvas.drawCircle(
      Offset(o1x, o1y),
      160,
      Paint()
        ..shader = RadialGradient(
          colors: [primary.withValues(alpha: .1), primary.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: Offset(o1x, o1y), radius: 160)),
    );

    final dot = Paint()..color = primary.withValues(alpha: .045);
    for (double x = 24; x < size.width; x += 24) {
      for (double y = 24; y < size.height * 0.5; y += 24) {
        canvas.drawCircle(Offset(x, y), 1.0, dot);
      }
    }
  }

  @override
  bool shouldRepaint(_MeshPainter o) => o.t != t;
}

// ─── Hero Header ─────────────────────────────────────────────────────────────

class _HeroHeader extends StatelessWidget {
  final String userName;
  final AnimationController shimmerController;
  final double scrollOffset;
  final dynamic colors;

  const _HeroHeader({
    required this.userName,
    required this.shimmerController,
    required this.scrollOffset,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final collapsed = scrollOffset > 60;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, collapsed ? 16.h : 24.h),
      decoration: BoxDecoration(
        color: colors.grey0,
        boxShadow: collapsed
            ? [
                BoxShadow(
                  color: colors.primary800.withValues(alpha: .07),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
        border: Border(
          bottom: BorderSide(
            color: colors.grey200.withValues(alpha: collapsed ? 1.0 : 0.0),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors.primary300, colors.primary800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary300.withValues(alpha: .3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset('assets/masters/logo.png'),
                ),
              ),
              SizedBox(width: 10.w),
              FadeInLeft(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 500),
                child: Text(
                  'Rafeeq',
                  style: TextStyle(
                    color: colors.primary900,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              const Spacer(),
              FadeInRight(
                duration: const Duration(milliseconds: 500),
                child: _IconBtn(
                  icon: Icons.notifications_outlined,
                  badge: true,
                  colors: colors,
                  onTap: () {},
                ),
              ),
              SizedBox(width: 8.w),
              FadeInRight(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 500),
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [colors.primary900, colors.primary800],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary800.withValues(alpha: .25),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'R',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: collapsed
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                FadeInDown(
                  delay: const Duration(milliseconds: 150),
                  duration: const Duration(milliseconds: 500),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Good morning,\n',
                          style: TextStyle(
                            color: colors.grey500,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: userName,
                          style: TextStyle(
                            color: colors.primary900,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    "Here's what's happening with your ventures today.",
                    style: TextStyle(
                      color: colors.grey500,
                      fontSize: 13.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            secondChild: const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final bool badge;
  final dynamic colors;
  final VoidCallback onTap;
  const _IconBtn({
    required this.icon,
    required this.colors,
    required this.onTap,
    this.badge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: colors.grey50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.grey200),
            ),
            child: Icon(icon, color: colors.grey700, size: 20.sp),
          ),
          if (badge)
            Positioned(
              right: 6.w,
              top: 6.h,
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.error500,
                  border: Border.all(color: colors.grey0, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Stats Section ────────────────────────────────────────────────────────────

class _StatsSection extends StatelessWidget {
  final List<StatsModel> stats;
  final dynamic colors;
  const _StatsSection({required this.stats, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 28.h),
        FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: _SectionLabel(title: 'Overview', colors: colors),
        ),
        SizedBox(height: 14.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.4,
          ),
          itemCount: stats.length,
          itemBuilder: (ctx, i) => FadeInUp(
            delay: Duration(milliseconds: 100 + i * 80),
            duration: const Duration(milliseconds: 500),
            child: _StatCard(stat: stats[i], colors: colors, index: i),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final StatsModel stat;
  final dynamic colors;
  final int index;
  const _StatCard({
    required this.stat,
    required this.colors,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isHighlighted = stat.isHighlighted == true;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: isHighlighted
            ? LinearGradient(
                colors: [colors.primary900, colors.primary800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isHighlighted ? null : colors.grey0,
        borderRadius: BorderRadius.circular(18.r),
        border: isHighlighted ? null : Border.all(color: colors.grey200),
        boxShadow: [
          BoxShadow(
            color: isHighlighted
                ? colors.primary800.withValues(alpha: .3)
                : colors.grey300.withValues(alpha: .4),
            blurRadius: isHighlighted ? 20 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            stat.label,
            style: TextStyle(
              color: isHighlighted
                  ? Colors.white.withValues(alpha: .75)
                  : colors.grey500,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.value,
                style: TextStyle(
                  color: isHighlighted ? Colors.white : colors.primary900,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? Colors.white.withValues(alpha: .15)
                      : colors.primary800.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  stat.changePercentage,
                  style: TextStyle(
                    color: isHighlighted ? Colors.white : colors.primary800,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Quick Actions ────────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  final dynamic colors;
  const _QuickActions({required this.colors});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionItem(
        icon: Icons.add_circle_outline_rounded,
        label: 'New Project',
        color: colors.primary800,
        isPrimary: true,
        onTap: () {
          GoRouter.of(context).push(Routes.createProjectSteps);
        },
      ),
      _ActionItem(
        onTap: () => GoRouter.of(context).push(Routes.allDraftsScreen),
        icon: Icons.edit_note_rounded,
        label: 'My Drafts',
        color: colors.grey600,
        isPrimary: false,
      ),
      _ActionItem(
        icon: Icons.bar_chart_rounded,
        label: 'Analytics',
        color: const Color(0xFF8B5CF6),
        isPrimary: false,
      ),
      _ActionItem(
        icon: Icons.calendar_today_rounded,
        label: 'Schedule',
        color: const Color(0xFFEA580C),
        isPrimary: false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInLeft(
          duration: const Duration(milliseconds: 500),
          child: _SectionLabel(title: 'Quick Actions', colors: colors),
        ),
        SizedBox(height: 14.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions.asMap().entries.map((e) {
            return FadeInUp(
              delay: Duration(milliseconds: 100 + e.key * 70),
              duration: const Duration(milliseconds: 450),
              child: _ActionBtn(item: e.value, colors: colors),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  final Color color;
  final bool isPrimary;
  final VoidCallback? onTap;
  _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.isPrimary,
    this.onTap,
  });
}

class _ActionBtn extends StatefulWidget {
  final _ActionItem item;
  final dynamic colors;
  const _ActionBtn({required this.item, required this.colors});

  @override
  State<_ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<_ActionBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.88,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - 40.w - 36.w) / 4;
    return GestureDetector(
      onTap: widget.item.onTap,
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: w,
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: widget.item.isPrimary
                      ? widget.item.color
                      : widget.item.color.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: widget.item.isPrimary
                      ? null
                      : Border.all(
                          color: widget.item.color.withValues(alpha: .2),
                        ),
                  boxShadow: widget.item.isPrimary
                      ? [
                          BoxShadow(
                            color: widget.item.color.withValues(alpha: .35),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  widget.item.icon,
                  color: widget.item.isPrimary
                      ? Colors.white
                      : widget.item.color,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                widget.item.label,
                style: TextStyle(
                  color: widget.colors.grey700,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Projects Section ─────────────────────────────────────────────────────────

class _ProjectsSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<PendingDraftModel> projects;
  final dynamic colors;
  final Color accentColor;
  final bool isDraft;
  final void Function(int projectId)? onTap;

  const _ProjectsSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.projects,
    required this.colors,
    required this.accentColor,
    this.isDraft = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: accentColor, size: 16.sp),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.primary900,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: colors.grey500, fontSize: 11.sp),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(Routes.allDraftsScreen);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: accentColor.withValues(alpha: .2),
                    ),
                  ),
                  child: Text(
                    'View all',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ...projects.asMap().entries.map(
            (e) => FadeInUp(
              delay: Duration(milliseconds: 80 * e.key),
              duration: const Duration(milliseconds: 400),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _ProjectCard(
                  onTap: onTap,
                  project: e.value,
                  colors: colors,
                  isDraft: isDraft,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final PendingDraftModel project;
  final dynamic colors;
  final bool isDraft;
  final void Function(int projectId)? onTap;
  const _ProjectCard({
    required this.project,
    required this.colors,
    required this.isDraft,
    this.onTap,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressCtrl;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _progressAnim = Tween(begin: 0.0, end: widget.project.fundingGoal).animate(
      CurvedAnimation(parent: _progressCtrl, curve: Curves.easeOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _progressCtrl.forward();
    });
  }

  @override
  void dispose() {
    _progressCtrl.dispose();
    super.dispose();
  }

  Color _statusColor() {
    switch (widget.project.status) {
      case 'active':
        return widget.colors.primary800;
      case 'approved ':
        return const Color(0xFFEA580C);
      default:
        return widget.colors.grey500;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = _statusColor();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      // ✅ FIX: pass projectId not id
      onPressed: () => widget.onTap!(widget.project.projectId),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: widget.colors.grey0,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: widget.colors.grey200),
          boxShadow: [
            BoxShadow(
              color: widget.colors.grey300.withValues(alpha: .4),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: sc),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    widget.project.name,
                    style: TextStyle(
                      color: widget.colors.primary900,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: sc.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    widget.project.status,
                    style: TextStyle(
                      color: sc,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
            if (!widget.isDraft && widget.project.fundingGoal > 0) ...[
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: AnimatedBuilder(
                        animation: _progressAnim,
                        builder: (_, __) => LinearProgressIndicator(
                          value: _progressAnim.value,
                          backgroundColor: widget.colors.grey100,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.colors.primary800,
                          ),
                          minHeight: 5.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  AnimatedBuilder(
                    animation: _progressAnim,
                    builder: (_, __) => Text(
                      '${(_progressAnim.value * 100).toInt()}%',
                      style: TextStyle(
                        color: widget.colors.grey600,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (widget.project.endDate.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 12.sp,
                    color: widget.colors.grey400,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Due ${widget.project.endDate}',
                    style: TextStyle(
                      color: widget.colors.grey500,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ],
            10.h.ph,
            if (widget.isDraft)
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  // ✅ FIX: pass projectId on Continue tap too
                  onTap: () => widget.onTap!(widget.project.projectId),
                  child: Container(
                    width: 100.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: widget.colors.primary800.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 12.sp,
                          color: widget.colors.primary800,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Continue',
                          style: TextStyle(
                            color: widget.colors.primary800,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  final dynamic colors;
  const _SectionLabel({required this.title, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: colors.primary800,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            color: colors.primary900,
            fontSize: 16.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
