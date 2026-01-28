import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.hintText = 'ابحث من هنا',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return AppTextFormField(
      prefixIcon: Icon(Icons.search_rounded, color: colors.grey400, size: 24.w),
      backgroundColor: colors.grey50,
      hintText: hintText,
      controller: controller,
      onChanged: onChanged,
      textAlign: TextAlign.right,
      contentPadding: EdgeInsets.symmetric(vertical: 14.h),
    );
  }
}
