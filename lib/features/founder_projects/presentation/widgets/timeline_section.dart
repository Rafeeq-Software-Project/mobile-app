import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/glass_card.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/section_title.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/timeline_tile.dart';

class TimelineSection extends StatelessWidget {
  final ProjectModel project;

  const TimelineSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'Timeline',
            icon: Icons.timeline_rounded,
            color: context.customAppColors.warning500,
          ),
          const SizedBox(height: 18),
          TimelineTile(
            icon: Icons.play_circle_outline_rounded,
            label: 'Start Date',
            date: project.startDate,
            color: context.customAppColors.primary500, // bright blue
            isFirst: true,
          ),
          TimelineTile(
            icon: Icons.stop_circle_outlined,
            label: 'End Date',
            date: project.endDate,
            color: context.customAppColors.error500, // red
          ),
          TimelineTile(
            icon: Icons.add_circle_outline_rounded,
            label: 'Created At',
            date: project.createdAt,
            color: context.customAppColors.info300, // soft purple
            isLast: true,
          ),
        ],
      ),
    );
  }
}
