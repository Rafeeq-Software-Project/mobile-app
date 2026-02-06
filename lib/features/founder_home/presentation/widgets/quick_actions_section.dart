import 'package:flutter/material.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'quick_action_button.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    final actions = [
      QuickActionData(
        icon: Icons.add_rounded,
        label: 'New Project',
        color: colors.primary700,
        onTap: () {},
      ),
      QuickActionData(
        icon: Icons.person_add_rounded,
        label: 'Invite',
        color: colors.accent600,
        onTap: () {},
      ),
      QuickActionData(
        icon: Icons.bar_chart_rounded,
        label: 'Analytics',
        color: const Color(0xFF9C27B0),
        onTap: () {},
      ),
      QuickActionData(
        icon: Icons.calendar_today_rounded,
        label: 'Schedule',
        color: const Color(0xFFFF6F00),
        onTap: () {},
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((action) {
        return QuickActionButton(action: action);
      }).toList(),
    );
  }
}

class QuickActionData {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  QuickActionData({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}
