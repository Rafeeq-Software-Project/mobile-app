import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_account/presentation/widgets/profile_info_tile.dart';
import 'package:rafeeq_app/features/founder_profile/data/models/founder_profile.dart';

class ProfileInfoSection extends StatelessWidget {
  final FounderProfile profile;

  const ProfileInfoSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey0,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          ProfileInfoTile(
            icon: Icons.business,
            title: "Company",
            value: profile.companyName,
          ),
          ProfileInfoTile(
            icon: Icons.work,
            title: "Role",
            value: profile.roleTitle,
          ),
          ProfileInfoTile(
            icon: Icons.phone,
            title: "Phone",
            value: profile.phoneNumber,
          ),
          ProfileInfoTile(
            icon: Icons.language,
            title: "Website",
            value: profile.websiteUrl,
          ),
          ProfileInfoTile(
            icon: Icons.category,
            title: "Industry",
            value: profile.industry,
          ),
        ],
      ),
    );
  }
}
