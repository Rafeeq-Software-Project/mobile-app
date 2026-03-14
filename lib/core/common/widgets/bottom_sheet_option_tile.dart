import 'package:rafeeq_app/core/utils/common_imports.dart';

class BottomSheetOptionTile extends StatelessWidget {
  final String icon;
  final String title;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isDestructive;

  const BottomSheetOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Center(
              child: SvgPicture.asset(
                icon,
                width: 24.w,
                height: 24.h,
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                    : null,
              ),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: Text(
                title,
                style: AppTextStyles.font16Regular.copyWith(
                  color: context.customAppColors.grey500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
