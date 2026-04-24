import 'package:flutter_animate/flutter_animate.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/screens/my_projects_screen.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/progress_section.dart';

class AnimatedProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;

  const AnimatedProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<AnimatedProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool progressStarted = false;
  late final AnimationController _progressController;
  late final Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeOutCubic,
    );
    Future.delayed(Duration(milliseconds: 300 + widget.index * 80), () {
      if (mounted) {
        setState(() => progressStarted = true);
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () =>
            GoRouter.of(context).push(Routes.projectDetailsScreen, extra: p.id),
        child:
            AnimatedContainer(
                  duration: 250.ms,
                  curve: Curves.easeOut,
                  transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: colors.grey0,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: _hovered
                            ? colors.primary800.withValues(alpha: .12)
                            : colors.grey300.withValues(alpha: .25),
                        blurRadius: _hovered ? 20 : 8,
                        spreadRadius: _hovered ? 1 : 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Header badges ───────────────────
                      Row(
                        children: [
                          _StatusBadge(status: p.status, colors: colors),
                          SizedBox(width: 8.w),
                          _CategoryBadge(label: p.category, colors: colors),
                        ],
                      ),
                      SizedBox(height: 14.h),

                      // ── Title ───────────────────────────
                      Text(
                        p.name,
                        style: AppTextStyles.font18Bold.copyWith(
                          color: colors.grey900,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      // ── Description ─────────────────────
                      Text(
                        p.description,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: colors.grey500,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 18.h),

                      // ── Progress ────────────────────────
                      ProgressSection(
                        project: p,
                        progressAnimation: _progressAnimation,
                        colors: colors,
                      ),

                      SizedBox(height: 14.h),

                      // ── Footer ──────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            p.status,
                            style: AppTextStyles.font13Regular.copyWith(
                              fontWeight: FontWeight.w600,
                              color: statusColor(p.status, colors),
                            ),
                          ),
                          _ActionButton(
                            label: p.status == 'Funded' ? 'Manage' : 'Details',
                            onTap: () => GoRouter.of(
                              context,
                            ).push(Routes.projectDetailsScreen, extra: p.id),
                            colors: colors,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                .animate(delay: (widget.index * 80).ms)
                .fadeIn(duration: 500.ms)
                .slideY(
                  begin: 0.15,
                  end: 0,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  STATUS BADGE
// ─────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final String status;
  final dynamic colors;

  const _StatusBadge({required this.status, required this.colors});

  @override
  Widget build(BuildContext context) {
    final bg = statusBg(status, colors);
    final fg = statusColor(status, colors);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          SizedBox(width: 5.w),
          Text(
            status,
            style: AppTextStyles.font12Regular.copyWith(
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CATEGORY BADGE
// ─────────────────────────────────────────────
class _CategoryBadge extends StatelessWidget {
  final String label;
  final dynamic colors;

  const _CategoryBadge({required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: colors.grey100,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.font12Regular.copyWith(
          fontWeight: FontWeight.w600,
          color: colors.grey600,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PROGRESS SECTION
// ─────────────────────────────────────────────

// ─────────────────────────────────────────────
//  ACTION BUTTON (Details / Manage)
// ─────────────────────────────────────────────
class _ActionButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final dynamic colors;

  const _ActionButton({
    required this.label,
    required this.onTap,
    required this.colors,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = widget.colors;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.93 : 1.0,
        duration: 120.ms,
        child: AnimatedContainer(
          duration: 180.ms,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: _pressed
                ? colors.primary800.withValues(alpha: .15)
                : colors.primary800.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.font13Regular.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.primary800,
                ),
              ),
              SizedBox(width: 5.w),
              AnimatedSlide(
                offset: _pressed ? const Offset(0.25, 0) : const Offset(0, 0),
                duration: 180.ms,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 15.sp,
                  color: colors.primary800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
