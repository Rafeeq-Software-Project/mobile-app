import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/glass_card.dart';
import 'package:rafeeq_app/features/founder_projects/presentation/widgets/section_title.dart';

class DescriptionSection extends StatefulWidget {
  final ProjectModel project;

  const DescriptionSection({super.key, required this.project});

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.project.description;
    final isLong = text.length > 180;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: 'About the Project',
            icon: Icons.info_outline_rounded,
            color: context.customAppColors.primary800,
          ),
          const SizedBox(height: 14),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _expanded || !isLong
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.customAppColors.neutral700,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            secondChild: Text(
              text,
              style: TextStyle(
                color: context.customAppColors.neutral700,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
          if (isLong) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Text(
                _expanded ? 'Show less' : 'Read more',
                style: TextStyle(
                  color: context.customAppColors.primary600,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
