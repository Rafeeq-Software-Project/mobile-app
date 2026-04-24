import 'package:animate_do/animate_do.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/stats_card.dart';

class StatsRow extends StatelessWidget {
  final ProjectModel project;

  const StatsRow({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final duration = project.endDate.difference(project.startDate).inDays;

    return Row(
      children: [
        Expanded(
          child: FadeInLeft(
            delay: const Duration(milliseconds: 150),
            child: StatCard(
              icon: Icons.attach_money_rounded,
              label: 'Funding Goal',
              value: '\$${_formatAmount(project.fundingGoal)}',
              color: context.customAppColors.primary600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: StatCard(
              icon: Icons.calendar_today_rounded,
              label: 'Duration',
              value: '$duration days',
              color: context.customAppColors.warning500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FadeInRight(
            delay: const Duration(milliseconds: 250),
            child: StatCard(
              icon: Icons.rocket_launch_rounded,
              label: 'Status',
              value: project.status,
              color: context.customAppColors.primary800,
            ),
          ),
        ),
      ],
    );
  }

  String _formatAmount(num amount) {
    if (amount >= 1000000) return '${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}K';
    return amount.toString();
  }
}
