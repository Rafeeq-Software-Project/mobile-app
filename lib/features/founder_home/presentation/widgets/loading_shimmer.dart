import 'package:animate_do/animate_do.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_home/presentation/widgets/skeleton_card.dart';

class LoadingShimmer extends StatefulWidget {
  final dynamic colors;
  final bool isHome;
  const LoadingShimmer({super.key, required this.colors, required this.isHome});

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
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

  @override
  Widget build(BuildContext context) {
    final count = widget.isHome ? 2 : 5;
    if (widget.isHome) {
      return Column(
        children: List.generate(count, (i) {
          final isLast = i == count - 1;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
            child: FadeInUp(
              delay: Duration(milliseconds: 60 * i),
              duration: const Duration(milliseconds: 350),
              child: AnimatedBuilder(
                animation: _shimmer,
                builder: (_, __) => SkeletonCard(
                  shimmerValue: _shimmer.value,
                  colors: widget.colors,
                ),
              ),
            ),
          );
        }),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 100.h),
      itemCount: count,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, i) => FadeInUp(
        delay: Duration(milliseconds: 60 * i),
        duration: const Duration(milliseconds: 350),
        child: AnimatedBuilder(
          animation: _shimmer,
          builder: (_, __) =>
              SkeletonCard(shimmerValue: _shimmer.value, colors: widget.colors),
        ),
      ),
    );
  }
}
