import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class OtpInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(int, String) onChanged;
  final Function(int) onBackspace;

  const OtpInputFields({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 48.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: colors.grey50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: controllers[index].text.isNotEmpty
                  ? colors.primary800
                  : colors.grey300,
              width: controllers[index].text.isNotEmpty ? 2 : 1,
            ),
            boxShadow: controllers[index].text.isNotEmpty
                ? [
                    BoxShadow(
                      color: colors.primary700.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,

            style: AppTextStyles.font20Bold.copyWith(color: colors.grey900),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              onChanged(index, value);
            },
            onTap: () {
              if (controllers[index].text.isNotEmpty) {
                controllers[index].clear();
              }
            },
            onEditingComplete: () {
              if (index < 5 && controllers[index].text.isNotEmpty) {
                focusNodes[index + 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }
}
