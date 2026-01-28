import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onAttachment;
  final VoidCallback? onVoice;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.onAttachment,
    this.onVoice,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  bool isAttachmentOpen = false;

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.background,
        boxShadow: [
          BoxShadow(
            color: colors.grey900.withValues(alpha: .05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: AppTextFormField(
                controller: widget.controller,
                textAlign: TextAlign.right,
                hintStyle: AppTextStyles.font14Regular.copyWith(
                  color: colors.primary800,
                ),
                hintText: 'اكتب رسالتك...',
              ),
            ),
            SizedBox(width: 12.w),

            if (widget.onVoice != null) ...[
              buildCircleButton(
                icon: Icons.mic_outlined,
                colors: colors,
                onTap: widget.onVoice!,
              ),
              SizedBox(width: 8.w),
            ],

            if (widget.onAttachment != null) ...[
              buildCircleButton(
                icon: isAttachmentOpen
                    ? Icons.highlight_off
                    : Icons.attach_file_rounded,
                colors: colors,
                onTap: () {
                  setState(() {
                    isAttachmentOpen = !isAttachmentOpen;
                  });
                  widget.onAttachment?.call();
                },
              ),
              SizedBox(width: 8.w),
            ],

            buildCircleButton(
              icon: Icons.arrow_forward_rounded,
              colors: colors,
              onTap: widget.onSend,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCircleButton({
    required IconData icon,
    required CustomAppColors colors,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25.r),
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: colors.primary800,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: colors.white, size: 18.sp),
      ),
    );
  }
}
