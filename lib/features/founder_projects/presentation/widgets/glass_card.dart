import 'package:rafeeq_app/core/utils/common_imports.dart';

class GlassCard extends StatelessWidget {
  final Widget child;

  const GlassCard({super.key, required this.child});

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
