import 'package:rafeeq_app/core/utils/common_imports.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: colors.primary800),
      title: Text(title, style: AppTextStyles.font12Regular),
      subtitle: Text(
        value?.isNotEmpty == true ? value! : "Not provided",
        style: AppTextStyles.font14SemiBold,
      ),
    );
  }
}
