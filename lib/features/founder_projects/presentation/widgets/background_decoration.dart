// ─── Background Decoration ───────────────────────────────────────────────────

import 'package:rafeeq_app/core/utils/common_imports.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({super.key});
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
