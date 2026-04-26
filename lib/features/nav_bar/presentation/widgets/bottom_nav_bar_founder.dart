import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafeeq_app/core/di/service_locator.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/chat/presentation/screens/conversations_screen.dart';
import 'package:rafeeq_app/features/chatbot/presentation/screens/chatbot_fab.dart';
import 'package:rafeeq_app/features/founder_home/presentation/logic/all_pending_drafts/pending_drafts_cubit.dart';
import 'package:rafeeq_app/features/founder_home/presentation/screens/founder_home_screen.dart';
import 'package:rafeeq_app/features/founder_profile/presentation/screens/founder_profile_screen.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/logic/get_projects/get_projects_cubit.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/screens/my_projects_screen.dart';
import 'package:rafeeq_app/generated/l10n.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';
import '../../../investor_applications/presentation/screens/investor_applications_screen.dart';

class CustomBottomNavBarFounder extends StatefulWidget {
  const CustomBottomNavBarFounder({super.key});

  @override
  State<CustomBottomNavBarFounder> createState() =>
      _CustomBottomNavBarFounderState();
}

class _CustomBottomNavBarFounderState extends State<CustomBottomNavBarFounder>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnims;
  late AnimationController _bubbleController;
  late Animation<double> _bubbleAnim;
  double _bubbleX = 0;
  double _prevBubbleX = 0;
  double _targetBubbleX = 0;

  late final List<Widget> _views;

  @override
  void initState() {
    super.initState();

    _views = [
      BlocProvider(
        create: (context) => getIt<PendingDraftsCubit>()..getAllPendingDrafts(),
        child: DashboardScreen(),
      ),
      BlocProvider(
        create: (_) => getIt<GetProjectsCubit>()..getProjects(),
        child: MyProjectsScreen(),
      ),
      InvestorApplicationsScreen(),
      ConversationsScreen(),
      FounderProfileScreen(),
    ];

    _controllers = List.generate(
      5,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );

    _scaleAnims = _controllers
        .map(
          (c) => Tween<double>(
            begin: 1.0,
            end: 1.25,
          ).animate(CurvedAnimation(parent: c, curve: Curves.elasticOut)),
        )
        .toList();

    _controllers[0].forward();

    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _bubbleAnim = CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.easeInOutCubic,
    );

    _bubbleAnim.addListener(() {
      setState(() {
        _bubbleX = _lerpDouble(_prevBubbleX, _targetBubbleX, _bubbleAnim.value);
      });
    });
  }

  double _lerpDouble(double a, double b, double t) => a + (b - a) * t;

  void _onTap(int index, double itemCenterX) {
    if (index == _selectedIndex) return;

    _controllers[_selectedIndex].reverse();
    _controllers[index].forward();
    _prevBubbleX = _bubbleX;
    _targetBubbleX = itemCenterX;
    _bubbleController
      ..reset()
      ..forward();

    setState(() => _selectedIndex = index);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    _bubbleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = context.customAppColors.primary800;
    final bg = context.customAppColors.grey0;

    final items = [
      _NavItem(assetIcon: AppIcons.homeInactive, label: S.of(context).home),
      _NavItem(
        assetIcon: AppIcons.teacherInactive,
        label: S.of(context).projects,
      ),
      _NavItem(
        assetIcon: AppIcons.teacherInactive,
        label: S.of(context).applications,
      ),
      _NavItem(assetIcon: AppIcons.massegeIcon, label: S.of(context).chat),
      _NavItem(assetIcon: AppIcons.personIcon, label: S.of(context).settings),
    ];

    return Scaffold(
      floatingActionButton: const ChatbotFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: context.customAppColors.background,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
              child: child,
            ),
          ),
          child: KeyedSubtree(
            key: ValueKey(_selectedIndex),
            child: _views[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: _CurvedNavBar(
        selectedIndex: _selectedIndex,
        bubbleX: _bubbleX,
        items: items,
        scaleAnims: _scaleAnims,
        primaryColor: primary,
        backgroundColor: bg,
        onTap: _onTap,
        onLayout: (x) {
          if (_bubbleX == 0) {
            setState(() {
              _bubbleX = x;
              _targetBubbleX = x;
              _prevBubbleX = x;
            });
          }
        },
      ),
    );
  }
}

// ─── Curved NavBar Widget ────────────────────────────────────────────────────

class _CurvedNavBar extends StatelessWidget {
  final int selectedIndex;
  final double bubbleX;
  final List<_NavItem> items;
  final List<Animation<double>> scaleAnims;
  final Color primaryColor;
  final Color backgroundColor;
  final void Function(int index, double centerX) onTap;
  final void Function(double x) onLayout;

  const _CurvedNavBar({
    required this.selectedIndex,
    required this.bubbleX,
    required this.items,
    required this.scaleAnims,
    required this.primaryColor,
    required this.backgroundColor,
    required this.onTap,
    required this.onLayout,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / items.length;
    const navHeight = 72.0;
    const bubbleRadius = 28.0;

    return SizedBox(
      height: navHeight + bubbleRadius,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Curved background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(width, navHeight),
              painter: _NavCurvePainter(
                bubbleCenterX: bubbleX,
                color: backgroundColor,
                shadowColor: Colors.black.withValues(alpha: .08),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: navHeight,
            child: Row(
              children: List.generate(items.length, (i) {
                return _NavItemWidget(
                  item: items[i],
                  index: i,
                  selectedIndex: selectedIndex,
                  itemWidth: itemWidth,
                  scaleAnim: scaleAnims[i],
                  primaryColor: primaryColor,
                  onTap: onTap,
                  onLayout: i == 0 ? onLayout : null,
                );
              }),
            ),
          ),

          // Floating bubble
          if (bubbleX > 0)
            Positioned(
              left: bubbleX - bubbleRadius,
              bottom: navHeight - bubbleRadius + 8,
              child: _FloatingBubble(
                radius: bubbleRadius,
                assetIcon: items[selectedIndex].assetIcon,
                color: primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Curve Painter ───────────────────────────────────────────────────────────

class _NavCurvePainter extends CustomPainter {
  final double bubbleCenterX;
  final Color color;
  final Color shadowColor;

  _NavCurvePainter({
    required this.bubbleCenterX,
    required this.color,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    canvas.drawPath(
      path,
      Paint()
        ..color = shadowColor
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    canvas.drawPath(path, Paint()..color = color);
  }

  Path _buildPath(Size size) {
    final cx = bubbleCenterX;
    const dipDepth = 28.0;
    const dipWidth = 52.0;
    const topY = 0.0; // ← غيري من 20 لـ 0

    return Path()
      ..moveTo(0, topY)
      ..lineTo(cx - dipWidth, topY)
      ..cubicTo(
        cx - dipWidth / 2,
        topY,
        cx - dipWidth / 2,
        topY + dipDepth, // ← plus بدل minus
        cx,
        topY + dipDepth, // ← plus بدل minus
      )
      ..cubicTo(
        cx + dipWidth / 2,
        topY + dipDepth, // ← plus بدل minus
        cx + dipWidth / 2,
        topY,
        cx + dipWidth,
        topY,
      )
      ..lineTo(size.width, topY)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldRepaint(_NavCurvePainter old) =>
      old.bubbleCenterX != bubbleCenterX;
}

// ─── Nav Item Widget ─────────────────────────────────────────────────────────

class _NavItemWidget extends StatelessWidget {
  final _NavItem item;
  final int index;
  final int selectedIndex;
  final double itemWidth;
  final Animation<double> scaleAnim;
  final Color primaryColor;
  final void Function(int index, double centerX) onTap;
  final void Function(double x)? onLayout;

  const _NavItemWidget({
    required this.item,
    required this.index,
    required this.selectedIndex,
    required this.itemWidth,
    required this.scaleAnim,
    required this.primaryColor,
    required this.onTap,
    this.onLayout,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        final centerX = itemWidth * index + itemWidth / 2;
        onTap(index, centerX);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: itemWidth,
        child: LayoutBuilder(
          builder: (ctx, _) {
            if (onLayout != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final box = ctx.findRenderObject() as RenderBox?;
                if (box != null && box.hasSize) {
                  final pos = box.localToGlobal(Offset.zero);
                  onLayout!(pos.dx + itemWidth / 2);
                }
              });
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Hide icon when active (bubble is showing instead)
                AnimatedOpacity(
                  opacity: isActive ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(
                    item.assetIcon,
                    height: 22,
                    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(height: 2),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isActive ? primaryColor : Colors.grey,
                  ),
                  child: Text(item.label),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 4 : 0,
                  height: isActive ? 4 : 0,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─── Floating Bubble ─────────────────────────────────────────────────────────

class _FloatingBubble extends StatelessWidget {
  final double radius;
  final String assetIcon;
  final Color color;

  const _FloatingBubble({
    required this.radius,
    required this.assetIcon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: .40),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          assetIcon,
          height: 22,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

// ─── Data Model ───────────────────────────────────────────────────────────────

class _NavItem {
  final String assetIcon;
  final String label;
  const _NavItem({required this.assetIcon, required this.label});
}
