import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_home/data/models/drafts/pending_draft_model.dart';
import 'package:rafeeq_app/features/founder_home/presentation/logic/draft_details/draft_details_cubit.dart';
import 'package:rafeeq_app/features/founder_home/presentation/logic/draft_details/draft_details_state.dart';

// ─── Helpers ──────────────────────────────────────────────────────────────────

String _fmtDate(String raw) {
  if (raw.isEmpty) return '—';
  try {
    return DateFormat('MMM d, yyyy').format(DateTime.parse(raw));
  } catch (_) {
    return raw;
  }
}

String _fmtMoney(double v) {
  if (v >= 1000000) return '\$${(v / 1000000).toStringAsFixed(1)}M';
  if (v >= 1000) return '\$${(v / 1000).toStringAsFixed(0)}K';
  return '\$${v.toStringAsFixed(0)}';
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class DraftDetailsScreen extends StatefulWidget {
  const DraftDetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<DraftDetailsScreen> createState() => _DraftDetailsScreenState();
}

class _DraftDetailsScreenState extends State<DraftDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgCtrl;

  @override
  void initState() {
    super.initState();
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Stack(
        children: [
          _AnimatedBg(controller: _bgCtrl, colors: colors),
          SafeArea(
            child: BlocBuilder<DraftDetailsCubit, DraftDetailsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox(),
                  loading: () => _LoadingView(colors: colors),
                  error: (msg) => _ErrorView(
                    message: msg,
                    colors: colors,
                    onRetry: () => context
                        .read<DraftDetailsCubit>()
                        .getDraftDetails(widget.id),
                  ),
                  success: (draft) =>
                      _SuccessView(draft: draft, colors: colors),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Animated Background ─────────────────────────────────────────────────────

class _AnimatedBg extends StatelessWidget {
  final AnimationController controller;
  final dynamic colors;
  const _AnimatedBg({required this.controller, required this.colors});

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
    final x = size.width * 0.85 + math.sin(t * 2 * math.pi) * 18;
    final y = size.height * 0.06 + math.cos(t * 2 * math.pi) * 10;
    canvas.drawCircle(
      Offset(x, y),
      140,
      Paint()
        ..shader = RadialGradient(
          colors: [primary.withValues(alpha: .1), primary.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: 140)),
    );
    final dot = Paint()..color = primary.withValues(alpha: .04);
    for (double dx = 20; dx < size.width; dx += 22) {
      for (double dy = 20; dy < size.height * 0.4; dy += 22) {
        canvas.drawCircle(Offset(dx, dy), 1.0, dot);
      }
    }
  }

  @override
  bool shouldRepaint(_BgPainter o) => o.t != t;
}

// ─── Success View ─────────────────────────────────────────────────────────────

class _SuccessView extends StatelessWidget {
  final PendingDraftModel draft;
  final dynamic colors;
  const _SuccessView({required this.draft, required this.colors});

  Color get _statusColor {
    switch (draft.status.toLowerCase().trim()) {
      case 'active':
        return const Color(0xFF16A34A);
      case 'in review':
        return const Color(0xFFEA580C);
      case 'rejected':
        return const Color(0xFFDC2626);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sc = _statusColor;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _DetailHeader(draft: draft, colors: colors, statusColor: sc),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
            child: FadeInUp(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 500),
              child: _HeroCard(draft: draft, colors: colors, statusColor: sc),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: FadeInUp(
              delay: const Duration(milliseconds: 180),
              duration: const Duration(milliseconds: 500),
              child: _InfoGrid(draft: draft, colors: colors),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: FadeInUp(
              delay: const Duration(milliseconds: 240),
              duration: const Duration(milliseconds: 500),
              child: _Section(
                title: 'Description',
                icon: Icons.description_outlined,
                colors: colors,
                child: Text(
                  draft.description,
                  style: TextStyle(
                    color: colors.grey700,
                    fontSize: 14.sp,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: FadeInUp(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 500),
              child: _Section(
                title: 'Use of Funds',
                icon: Icons.account_balance_wallet_outlined,
                colors: colors,
                child: Text(
                  draft.useOfFunds,
                  style: TextStyle(
                    color: colors.grey700,
                    fontSize: 14.sp,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: FadeInUp(
              delay: const Duration(milliseconds: 360),
              duration: const Duration(milliseconds: 500),
              child: _FounderCard(draft: draft, colors: colors),
            ),
          ),
        ),
        if (draft.rejectionReason != null && draft.rejectionReason!.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: FadeInUp(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                child: _RejectionBanner(
                  reason: draft.rejectionReason!,
                  colors: colors,
                ),
              ),
            ),
          ),
        if (draft.liveProject != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: FadeInUp(
                delay: const Duration(milliseconds: 420),
                duration: const Duration(milliseconds: 500),
                child: _LiveProjectBanner(
                  live: draft.liveProject!,
                  colors: colors,
                ),
              ),
            ),
          ),
        SliverToBoxAdapter(child: SizedBox(height: 40.h)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: FadeInUp(
              delay: const Duration(milliseconds: 460),
              duration: const Duration(milliseconds: 500),
              child: _ActionButtons(draft: draft, colors: colors),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 60.h)),
      ],
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _DetailHeader extends StatelessWidget {
  final PendingDraftModel draft;
  final dynamic colors;
  final Color statusColor;
  const _DetailHeader({
    required this.draft,
    required this.colors,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
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
          Expanded(
            child: FadeInLeft(
              delay: const Duration(milliseconds: 80),
              duration: const Duration(milliseconds: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Draft Details',
                    style: TextStyle(
                      color: colors.primary900,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    '#${draft.id} · ${draft.category}',
                    style: TextStyle(color: colors.grey500, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
          FadeInRight(
            duration: const Duration(milliseconds: 400),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: statusColor.withValues(alpha: .25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    draft.status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
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

// ─── Hero Card ────────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  final PendingDraftModel draft;
  final dynamic colors;
  final Color statusColor;
  const _HeroCard({
    required this.draft,
    required this.colors,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary900, colors.primary800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: colors.primary800.withValues(alpha: .35),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  draft.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              _HeroStat(
                label: 'Funding Goal',
                value: _fmtMoney(draft.fundingGoal),
                icon: Icons.monetization_on_outlined,
              ),
              SizedBox(width: 16.w),
              _HeroStat(
                label: 'Start Date',
                value: _fmtDate(draft.startDate),
                icon: Icons.play_circle_outline_rounded,
              ),
              SizedBox(width: 16.w),
              _HeroStat(
                label: 'End Date',
                value: _fmtDate(draft.endDate),
                icon: Icons.flag_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _HeroStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 11, color: Colors.white54),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Info Grid ────────────────────────────────────────────────────────────────

class _InfoGrid extends StatelessWidget {
  final PendingDraftModel draft;
  final dynamic colors;
  const _InfoGrid({required this.draft, required this.colors});

  @override
  Widget build(BuildContext context) {
    final items = [
      _InfoItem(
        label: 'Category',
        value: draft.category,
        icon: Icons.category_outlined,
      ),
      _InfoItem(
        label: 'Created',
        value: _fmtDate(draft.createdAt),
        icon: Icons.add_circle_outline_rounded,
      ),
      _InfoItem(
        label: 'Updated',
        value: _fmtDate(draft.updatedAt ?? ''),
        icon: Icons.update_rounded,
      ),
      _InfoItem(
        label: 'Reviewed By',
        value: draft.reviewedByRole ?? '—',
        icon: Icons.verified_user_outlined,
      ),
      _InfoItem(
        label: 'Reviewed At',
        value: _fmtDate(draft.reviewedAt ?? ''),
        icon: Icons.check_circle_outline_rounded,
      ),
      _InfoItem(
        label: 'Project ID',
        value: '#${draft.projectId}',
        icon: Icons.tag_rounded,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 2.2,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => FadeInUp(
        delay: Duration(milliseconds: 40 * i),
        duration: const Duration(milliseconds: 350),
        child: _InfoTile(item: items[i], colors: colors),
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  final IconData icon;
  const _InfoItem({
    required this.label,
    required this.value,
    required this.icon,
  });
}

class _InfoTile extends StatelessWidget {
  final _InfoItem item;
  final dynamic colors;
  const _InfoTile({required this.item, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: colors.grey0,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: colors.grey200),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: colors.primary800.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(item.icon, size: 14.sp, color: colors.primary800),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.label,
                  style: TextStyle(
                    color: colors.grey500,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.value,
                  style: TextStyle(
                    color: colors.primary900,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section ──────────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final dynamic colors;
  final Widget child;
  const _Section({
    required this.title,
    required this.icon,
    required this.colors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey0,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.grey200),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .25),
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
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: colors.primary800.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 14.sp, color: colors.primary800),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  color: colors.primary900,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}

// ─── Founder Card ─────────────────────────────────────────────────────────────

class _FounderCard extends StatelessWidget {
  final PendingDraftModel draft;
  final dynamic colors;
  const _FounderCard({required this.draft, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey0,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.grey200),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .25),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [colors.primary300, colors.primary800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.primary800.withValues(alpha: .25),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                draft.founderName.isNotEmpty
                    ? draft.founderName[0].toUpperCase()
                    : 'F',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  draft.founderName,
                  style: TextStyle(
                    color: colors.primary900,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (draft.founderCompany != null &&
                    draft.founderCompany!.isNotEmpty) ...[
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Icon(
                        Icons.business_outlined,
                        size: 12.sp,
                        color: colors.grey400,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        draft.founderCompany!,
                        style: TextStyle(
                          color: colors.grey500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 3.h),
                Text(
                  'Founder ID #${draft.founderId}',
                  style: TextStyle(color: colors.grey400, fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colors.primary800.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.person_outline_rounded,
              color: colors.primary800,
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Rejection Banner ─────────────────────────────────────────────────────────

class _RejectionBanner extends StatelessWidget {
  final String reason;
  final dynamic colors;
  const _RejectionBanner({required this.reason, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFDC2626).withValues(alpha: .06),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFDC2626).withValues(alpha: .2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFDC2626).withValues(alpha: .1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.cancel_outlined,
              color: const Color(0xFFDC2626),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rejection Reason',
                  style: TextStyle(
                    color: const Color(0xFFDC2626),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  reason,
                  style: TextStyle(
                    color: const Color(0xFFDC2626).withValues(alpha: .8),
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Live Project Banner ──────────────────────────────────────────────────────

class _LiveProjectBanner extends StatelessWidget {
  final dynamic live;
  final dynamic colors;
  const _LiveProjectBanner({required this.live, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF16A34A).withValues(alpha: .08),
            const Color(0xFF16A34A).withValues(alpha: .03),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF16A34A).withValues(alpha: .2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF16A34A).withValues(alpha: .12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.verified_rounded,
              color: const Color(0xFF16A34A),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live Project',
                  style: TextStyle(
                    color: const Color(0xFF16A34A),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  live.name ?? '—',
                  style: TextStyle(color: colors.grey600, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.sp,
            color: const Color(0xFF16A34A),
          ),
        ],
      ),
    );
  }
}

// ─── Action Buttons ───────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  final PendingDraftModel draft;
  final dynamic colors;
  const _ActionButtons({required this.draft, required this.colors});

  @override
  Widget build(BuildContext context) {
    final isRejected = draft.status.toLowerCase().trim() == 'rejected';

    return Row(
      children: [
        Expanded(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // ✅ FIX: use projectId not draft.id
              GoRouter.of(
                context,
              ).push(Routes.createProjectSteps, extra: draft.projectId);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isRejected ? Icons.refresh_rounded : Icons.edit_outlined,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    isRejected ? 'Resubmit' : 'Edit Draft',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: colors.grey0,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: colors.grey200),
            boxShadow: [
              BoxShadow(
                color: colors.grey300.withValues(alpha: .3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.share_outlined, color: colors.grey600, size: 20.sp),
        ),
      ],
    );
  }
}

// ─── Loading View ─────────────────────────────────────────────────────────────

class _LoadingView extends StatefulWidget {
  final dynamic colors;
  const _LoadingView({required this.colors});

  @override
  State<_LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<_LoadingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _shimmer = Tween<double>(
      begin: -1.5,
      end: 2.5,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _bone({required double w, required double h, double r = 8}) =>
      AnimatedBuilder(
        animation: _shimmer,
        builder: (_, __) => Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(r),
            gradient: LinearGradient(
              begin: Alignment(_shimmer.value - 1, 0),
              end: Alignment(_shimmer.value + 1, 0),
              colors: [
                widget.colors.grey200,
                widget.colors.grey100,
                widget.colors.grey200,
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width - 40.w;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _bone(w: 40.w, h: 40.w, r: 12),
              SizedBox(width: 14.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bone(w: 120.w, h: 16.h),
                  SizedBox(height: 5.h),
                  _bone(w: 80.w, h: 12.h),
                ],
              ),
              const Spacer(),
              _bone(w: 80.w, h: 28.h, r: 20),
            ],
          ),
          SizedBox(height: 20.h),
          _bone(w: sw, h: 120.h, r: 20),
          SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 2.2,
            children: List.generate(
              6,
              (_) => _bone(w: double.infinity, h: double.infinity, r: 14),
            ),
          ),
          SizedBox(height: 16.h),
          _bone(w: sw, h: 100.h, r: 16),
          SizedBox(height: 16.h),
          _bone(w: sw, h: 80.h, r: 16),
          SizedBox(height: 16.h),
          _bone(w: sw, h: 72.h, r: 16),
        ],
      ),
    );
  }
}

// ─── Error View ───────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final dynamic colors;
  final VoidCallback onRetry;
  const _ErrorView({
    required this.message,
    required this.colors,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInUp(
        duration: const Duration(milliseconds: 400),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
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
              SizedBox(height: 16.h),
              Text(
                'Failed to load',
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
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: onRetry,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
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
                    'Try Again',
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
      ),
    );
  }
}
