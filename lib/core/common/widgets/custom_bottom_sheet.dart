import 'package:rafeeq_app/core/utils/common_imports.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.children,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(),
              Text(
                title,
                style: AppTextStyles.font18SemiBold.copyWith(
                  color: context.customAppColors.primary500,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: context.customAppColors.error500,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          Divider(
            color: context.customAppColors.grey200,
            thickness: 1,
            height: 1,
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: padding ?? EdgeInsets.symmetric(vertical: 8.h),
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required List<Widget> children,
    double? height,
    EdgeInsetsGeometry? padding,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet(
        title: title,
        height: height,
        padding: padding,
        children: children,
      ),
    );
  }
}
