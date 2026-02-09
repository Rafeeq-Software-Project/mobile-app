import 'package:flutter/material.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class DetailAppBar extends StatelessWidget {
  final VoidCallback onBackTap;
  final VoidCallback onShareTap;

  const DetailAppBar({
    super.key,
    required this.onBackTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return SliverAppBar(
      backgroundColor: colors.grey0,
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colors.grey900),
        onPressed: onBackTap,
      ),
      title: Text(
        'Project Details',
        style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.share, color: colors.grey900),
          onPressed: onShareTap,
        ),
      ],
    );
  }
}
