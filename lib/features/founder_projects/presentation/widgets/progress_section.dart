import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/screens/my_projects_screen.dart';

class ProgressSection extends StatelessWidget {
  final ProjectModel project;
  final Animation<double> progressAnimation;
  final dynamic colors;

  const ProgressSection({
    super.key,
    required this.project,
    required this.progressAnimation,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final fillColor = statusColor(project.status, colors);
    final percent = (project.fundingGoal / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Funding Progress',
              style: AppTextStyles.font12Regular.copyWith(
                color: colors.grey500,
              ),
            ),
            AnimatedBuilder(
              animation: progressAnimation,
              builder: (_, __) => Text(
                '${(percent * progressAnimation.value * 100).toInt()}%',
                style: AppTextStyles.font12Regular.copyWith(
                  fontWeight: FontWeight.w700,
                  color: fillColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            height: 7.h,
            color: colors.grey100,
            child: AnimatedBuilder(
              animation: progressAnimation,
              builder: (_, __) => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percent * progressAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
