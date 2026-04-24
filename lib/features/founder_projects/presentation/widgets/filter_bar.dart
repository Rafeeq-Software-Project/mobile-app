import 'package:flutter_animate/flutter_animate.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';

class FilterBar extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final ValueChanged<String> onSelected;
  final dynamic colors;

  const FilterBar({
    super.key,
    required this.filters,
    required this.selected,
    required this.onSelected,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          color: colors.grey0,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.asMap().entries.map((e) {
                final i = e.key;
                final label = e.value;
                return Padding(
                  padding: EdgeInsets.only(
                    right: i < filters.length - 1 ? 8.w : 0,
                  ),
                  child: _AnimatedFilterChip(
                    label: label,
                    isSelected: selected == label,
                    onTap: () => onSelected(label),
                    colors: colors,
                    delay: i * 60,
                  ),
                );
              }).toList(),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: 100.ms)
        .slideY(begin: -0.2, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }
}

class _AnimatedFilterChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final dynamic colors;
  final int delay;

  const _AnimatedFilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colors,
    this.delay = 0,
  });

  @override
  State<_AnimatedFilterChip> createState() => _AnimatedFilterChipState();
}

class _AnimatedFilterChipState extends State<_AnimatedFilterChip>
    with SingleTickerProviderStateMixin {
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
            scale: _pressed ? 0.92 : 1.0,
            duration: 120.ms,
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: 250.ms,
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: widget.isSelected ? colors.primary800 : colors.grey100,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: widget.isSelected
                    ? [
                        BoxShadow(
                          color: colors.primary800.withValues(alpha: .35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: AnimatedDefaultTextStyle(
                duration: 200.ms,
                style: AppTextStyles.font13Regular.copyWith(
                  fontWeight: FontWeight.w600,
                  color: widget.isSelected ? colors.grey0 : colors.grey600,
                ),
                child: Text(widget.label),
              ),
            ),
          ),
        )
        .animate(delay: widget.delay.ms)
        .fadeIn(duration: 350.ms)
        .slideX(begin: 0.3, end: 0, duration: 350.ms, curve: Curves.easeOut);
  }
}
