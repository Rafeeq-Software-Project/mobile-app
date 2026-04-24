import 'package:rafeeq_app/core/utils/common_imports.dart';

class TimelineTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final DateTime date;
  final Color color;
  final bool isFirst;
  final bool isLast;

  const TimelineTile({
    super.key,
    required this.icon,
    required this.label,
    required this.date,
    required this.color,
    this.isFirst = false,
    this.isLast = false,
  });

  String _formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day} ${months[d.month - 1]}, ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        width: 1.5,
                        color: context.customAppColors.primary600.withValues(
                          alpha: .18,
                        ),
                      ),
                    ),
                  ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: .10),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color.withValues(alpha: .30),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                if (!isLast)
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        width: 1.5,
                        color: context.customAppColors.primary600.withValues(
                          alpha: 0.18,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: context.customAppColors.grey600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    _formatDate(date.toLocal()),
                    style: TextStyle(
                      color: context.customAppColors.primary900,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
