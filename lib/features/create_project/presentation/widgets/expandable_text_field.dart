import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ExpandableTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final int maxCharacters;
  final String? Function(String?)? validator;

  const ExpandableTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.maxLines = 5,
    this.maxCharacters = 500,
    this.validator,
  });

  @override
  State<ExpandableTextField> createState() => _ExpandableTextFieldState();
}

class _ExpandableTextFieldState extends State<ExpandableTextField> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final currentLength = widget.controller.text.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with helper icon
        Row(
          children: [
            Text(
              widget.label,
              style: AppTextStyles.font14SemiBold.copyWith(
                color: colors.grey900,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: colors.grey200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.help_outline,
                size: 14.sp,
                color: colors.grey600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Text Field
        TextFormField(
          controller: widget.controller,
          maxLines: _isExpanded ? widget.maxLines : 3,
          maxLength: widget.maxCharacters,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.font14Regular.copyWith(
              color: colors.grey400,
            ),
            filled: true,
            fillColor: colors.grey50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.grey300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.grey300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.primary800, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.error500),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colors.error500, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            counterText: '',
          ),
          validator: widget.validator,
          onChanged: (value) {
            setState(() {});
          },
        ),
        SizedBox(height: 8.h),

        // Character count and expand button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$currentLength/${widget.maxCharacters} characters',
              style: AppTextStyles.font12Regular.copyWith(
                color: currentLength > widget.maxCharacters * 0.9
                    ? colors.warning500
                    : colors.grey600,
              ),
            ),
            if (!_isExpanded)
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = true;
                  });
                },
                child: Text(
                  'Show more',
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: colors.primary800,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
