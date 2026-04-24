import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/glass_card.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/section_title.dart';

class FundingSection extends StatelessWidget {
  final ProjectModel project;

  const FundingSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Funding',
            icon: Icons.account_balance_wallet_outlined,
            color: context.customAppColors.primary600,
          ),
          const SizedBox(height: 18),
          // Funding Goal Display
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.customAppColors.primary600.withValues(alpha: 0.08),
                  context.customAppColors.primary400.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: context.customAppColors.primary600.withValues(
                  alpha: .18,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.flag_rounded,
                  color: context.customAppColors.primary600,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Funding Goal',
                      style: TextStyle(
                        color: context.customAppColors.grey500,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '\$${project.fundingGoal.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: context.customAppColors.primary600,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Use of Funds',
            style: TextStyle(
              color: context.customAppColors.grey500,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project.useOfFunds,
            style: TextStyle(
              color: context.customAppColors.neutral700,
              fontSize: 14,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
