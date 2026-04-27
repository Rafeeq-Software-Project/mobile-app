import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_home/data/models/drafts/pending_draft_model.dart';
import 'package:rafeeq_app/features/founder_home/presentation/logic/all_pending_drafts/pending_drafts_cubit.dart';
import 'package:rafeeq_app/features/founder_home/presentation/logic/all_pending_drafts/pending_drafts_state.dart';
import 'package:rafeeq_app/features/founder_home/presentation/widgets/loading_shimmer.dart';

String _formatDueDate(String rawDate) {
  if (rawDate.isEmpty) return '';
  try {
    final date = DateTime.parse(rawDate);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    final diff = target.difference(today).inDays;

    if (diff == 0) return 'Due Today';
    if (diff == 1) return 'Due Tomorrow';
    if (diff == -1) return 'Due Yesterday';
    if (diff < 0) return 'Overdue · ${DateFormat('MMM d').format(date)}';
    if (diff <= 7) return 'In $diff days';
    return 'Due ${DateFormat('MMM d, yyyy').format(date)}';
  } catch (_) {
    return rawDate;
  }
}

Color _dueDateColor(String rawDate, dynamic colors) {
  if (rawDate.isEmpty) return colors.grey400;
  try {
    final date = DateTime.parse(rawDate);
    final now = DateTime.now();
    final diff = DateTime(
      date.year,
      date.month,
      date.day,
    ).difference(DateTime(now.year, now.month, now.day)).inDays;
    if (diff < 0) return const Color(0xFFDC2626);
    if (diff <= 3) return const Color(0xFFEA580C);
    return colors.grey400;
  } catch (_) {
    return colors.grey400;
  }
}

class AllDraftsScreen extends StatefulWidget {
  const AllDraftsScreen({super.key});

  @override
  State<AllDraftsScreen> createState() => _AllDraftsScreenState();
}

class _AllDraftsScreenState extends State<AllDraftsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgController;
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Pending', 'In Review', 'Rejected'];

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  List<PendingDraftModel> _filtered(List<PendingDraftModel> all) {
    if (_selectedFilter == 'All') return all;
    return all
        .where((d) => d.status.toLowerCase() == _selectedFilter.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Stack(
        children: [
          _AnimatedBackground(controller: _bgController, colors: colors),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(colors: colors),
                _FilterBar(
                  filters: _filters,
                  selected: _selectedFilter,
                  colors: colors,
                  onSelect: (f) => setState(() => _selectedFilter = f),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: BlocBuilder<PendingDraftsCubit, PendingDraftsState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox(),
                        loading: () =>
                            LoadingShimmer(colors: colors, isHome: false),
                        error: (msg) =>
                            _ErrorView(message: msg, colors: colors),
                        success: (drafts) {
                          final filtered = _filtered(drafts);
                          if (filtered.isEmpty) {
                            return _EmptyView(
                              filter: _selectedFilter,
                              colors: colors,
                            );
                          }
                          return _DraftsList(drafts: filtered, colors: colors);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FadeInUp(
        delay: const Duration(milliseconds: 400),
        child: _NewDraftFAB(colors: colors),
      ),
    );
  }
}

// ─── Animated Background ─────────────────────────────────────────────────────

class _AnimatedBackground extends StatelessWidget {
  final AnimationController controller;
  final dynamic colors;
  const _AnimatedBackground({required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => CustomPaint(
        painter: _BgPainter(controller.value, colors.primary800),
        size: Size.infinite,
      ),
    );
  }
}

class _BgPainter extends CustomPainter {
  final double t;
  final Color primary;
  _BgPainter(this.t, this.primary);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFF0F4FF),
    );

    final x1 = size.width * 0.15 + math.sin(t * 2 * math.pi) * 20;
    final y1 = size.height * 0.08 + math.cos(t * 2 * math.pi) * 12;
    canvas.drawCircle(
      Offset(x1, y1),
      130,
      Paint()
        ..shader = RadialGradient(
          colors: [
            primary.withValues(alpha: .12),
            primary.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(x1, y1), radius: 130)),
    );

    final dot = Paint()..color = primary.withValues(alpha: .04);
    for (double x = 20; x < size.width; x += 22) {
      for (double y = 20; y < size.height * 0.45; y += 22) {
        canvas.drawCircle(Offset(x, y), 1.0, dot);
      }
    }
  }

  @override
  bool shouldRepaint(_BgPainter o) => o.t != t;
}

// ─── Header ──────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final dynamic colors;
  const _Header({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      child: Row(
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 400),
            child: GestureDetector(
              onTap: () => GoRouter.of(context).pop(),
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: colors.grey0,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.grey200),
                  boxShadow: [
                    BoxShadow(
                      color: colors.grey300.withValues(alpha: .3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colors.primary900,
                  size: 16.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          FadeInLeft(
            delay: const Duration(milliseconds: 80),
            duration: const Duration(milliseconds: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Drafts',
                  style: TextStyle(
                    color: colors.primary900,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                Text(
                  'Manage your pending submissions',
                  style: TextStyle(color: colors.grey500, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          const Spacer(),
          FadeInRight(
            duration: const Duration(milliseconds: 400),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: colors.grey0,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.grey200),
              ),
              child: Icon(
                Icons.sort_rounded,
                color: colors.grey700,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Filter Bar ───────────────────────────────────────────────────────────────

class _FilterBar extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final dynamic colors;
  final ValueChanged<String> onSelect;
  const _FilterBar({
    required this.filters,
    required this.selected,
    required this.colors,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (ctx, i) {
          final isSelected = filters[i] == selected;
          return FadeInLeft(
            delay: Duration(milliseconds: 60 * i),
            duration: const Duration(milliseconds: 350),
            child: GestureDetector(
              onTap: () => onSelect(filters[i]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary800 : colors.grey0,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? colors.primary800 : colors.grey200,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: colors.primary800.withValues(alpha: .25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  filters[i],
                  style: TextStyle(
                    color: isSelected ? Colors.white : colors.grey600,
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Drafts List ──────────────────────────────────────────────────────────────

class _DraftsList extends StatelessWidget {
  final List<PendingDraftModel> drafts;
  final dynamic colors;
  const _DraftsList({required this.drafts, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 100.h),
      itemCount: drafts.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (ctx, i) => FadeInUp(
        delay: Duration(milliseconds: 60 * i),
        duration: const Duration(milliseconds: 400),
        child: _DraftCard(draft: drafts[i], colors: colors, index: i),
      ),
    );
  }
}

// ─── Draft Card ───────────────────────────────────────────────────────────────

class _DraftCard extends StatefulWidget {
  final PendingDraftModel draft;
  final dynamic colors;
  final int index;
  const _DraftCard({
    required this.draft,
    required this.colors,
    required this.index,
  });

  @override
  State<_DraftCard> createState() => _DraftCardState();
}

class _DraftCardState extends State<_DraftCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 130),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color get _statusColor {
    switch (widget.draft.status.toLowerCase().trim()) {
      case 'active':
        return widget.colors.primary800;
      case 'in review':
        return const Color(0xFFEA580C);
      case 'rejected':
        return const Color(0xFFDC2626);
      default:
        return widget.colors.grey500;
    }
  }

  String get _statusLabel {
    switch (widget.draft.status.toLowerCase().trim()) {
      case 'active':
        return 'Active';
      case 'in review':
        return 'In Review';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = _statusColor;

    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      onTap: () {
        // ✅ FIX: use projectId not id
        GoRouter.of(
          context,
        ).push(Routes.draftsDetailsScreen, extra: widget.draft.projectId);
      },
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: widget.colors.grey0,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: widget.colors.grey200),
            boxShadow: [
              BoxShadow(
                color: widget.colors.grey300.withValues(alpha: .35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.colors.primary300,
                          widget.colors.primary800,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.draft.name,
                          style: TextStyle(
                            color: widget.colors.primary900,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: sc.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: sc.withValues(alpha: .25),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: sc,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                _statusLabel,
                                style: TextStyle(
                                  color: sc,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: widget.colors.grey400,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Divider(height: 1, color: widget.colors.grey100),
              ),
              Row(
                children: [
                  if (widget.draft.endDate.isNotEmpty) ...[
                    _DueDateBadge(
                      rawDate: widget.draft.endDate,
                      colors: widget.colors,
                    ),
                    SizedBox(width: 10.w),
                  ],
                  if (widget.draft.fundingGoal > 0) ...[
                    Icon(
                      Icons.attach_money_rounded,
                      size: 13.sp,
                      color: widget.colors.grey400,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '\$${widget.draft.fundingGoal.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: widget.colors.grey500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                  const Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // ✅ FIX: use projectId not id
                      GoRouter.of(context).push(
                        Routes.draftsDetailsScreen,
                        extra: widget.draft.projectId,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.colors.primary300,
                            widget.colors.primary800,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: widget.colors.primary800.withValues(
                              alpha: .25,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 12.sp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Empty View ───────────────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  final String filter;
  final dynamic colors;
  const _EmptyView({required this.filter, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: colors.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit_note_rounded,
                size: 36.sp,
                color: colors.grey400,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              filter == 'All' ? 'No drafts yet' : 'No $filter drafts',
              style: TextStyle(
                color: colors.primary900,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Start a new project to see your drafts here.',
              style: TextStyle(color: colors.grey500, fontSize: 13.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () =>
                  GoRouter.of(context).push(Routes.createProjectSteps),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.primary300, colors.primary800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary800.withValues(alpha: .3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Create New Project',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
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

// ─── Error View ───────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final dynamic colors;
  const _ErrorView({required this.message, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInUp(
        duration: const Duration(milliseconds: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: const Color(0xFFDC2626).withValues(alpha: .08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 32.sp,
                color: const Color(0xFFDC2626),
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              'Something went wrong',
              style: TextStyle(
                color: colors.primary900,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              message,
              style: TextStyle(color: colors.grey500, fontSize: 13.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () =>
                  context.read<PendingDraftsCubit>().getAllPendingDrafts(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: colors.primary800.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: colors.primary800.withValues(alpha: .2),
                  ),
                ),
                child: Text(
                  'Try again',
                  style: TextStyle(
                    color: colors.primary800,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
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

// ─── Due Date Badge ───────────────────────────────────────────────────────────

class _DueDateBadge extends StatelessWidget {
  final String rawDate;
  final dynamic colors;
  const _DueDateBadge({required this.rawDate, required this.colors});

  @override
  Widget build(BuildContext context) {
    final label = _formatDueDate(rawDate);
    final color = _dueDateColor(rawDate, colors);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withValues(alpha: .1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_outlined, size: 11.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── FAB ─────────────────────────────────────────────────────────────────────

class _NewDraftFAB extends StatelessWidget {
  final dynamic colors;
  const _NewDraftFAB({required this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(Routes.createProjectSteps),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary300, colors.primary800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: colors.primary800.withValues(alpha: .35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_rounded, color: Colors.white, size: 20),
            SizedBox(width: 8.w),
            Text(
              'New Project',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
