import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';

class ApplyAppBar extends StatelessWidget {
  final VoidCallback onBackTap;
  const ApplyAppBar({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: colors.grey0,
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: colors.grey900),
            onPressed: onBackTap,
          ),
          SizedBox(width: 8.w),
          Text(
            'Apply to Project',
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
          ),
        ],
      ),
    );
  }
}

class ProjectApplyHeader extends StatelessWidget {
  final String projectName, founderName, imageUrl;
  const ProjectApplyHeader({
    super.key,
    required this.projectName,
    required this.founderName,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.grey200),
      ),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
              ),
            ),
            child: Icon(Icons.eco, color: colors.white, size: 32.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: colors.primary800.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'APPLYING TO',
                    style: AppTextStyles.font12Bold.copyWith(
                      color: colors.primary800,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  projectName,
                  style: AppTextStyles.font16Bold.copyWith(
                    color: colors.grey900,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 14.sp,
                      color: colors.grey600,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      founderName,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.grey600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageSection extends StatelessWidget {
  final TextEditingController controller;
  const MessageSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.message_outlined, size: 20.sp, color: colors.primary800),
            SizedBox(width: 8.w),
            Text(
              'Your Message',
              style: AppTextStyles.font16SemiBold.copyWith(
                color: colors.grey900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: colors.grey50,
            border: Border.all(color: colors.grey200),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Introduction & Interest',
                style: AppTextStyles.font12SemiBold.copyWith(
                  color: colors.grey700,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your message...',
                  filled: true,
                  fillColor: colors.grey50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '0/500',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: colors.grey600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AttachmentsSection extends StatelessWidget {
  final List<String> attachments;
  final VoidCallback onAddAttachment;
  final Function(int) onRemoveAttachment;
  const AttachmentsSection({
    super.key,
    required this.attachments,
    required this.onAddAttachment,
    required this.onRemoveAttachment,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.attach_file, size: 20.sp, color: colors.primary800),
            SizedBox(width: 8.w),
            Text(
              'Attachments',
              style: AppTextStyles.font16Bold.copyWith(color: colors.grey900),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: onAddAttachment,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: colors.grey50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: colors.primary800,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 48.sp,
                  color: colors.primary800,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Click to upload',
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: colors.primary800,
                  ),
                ),
                Text(
                  'or drag and drop',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: colors.grey600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'PNG, DOCX up to 10MB in total',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: colors.grey500,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (attachments.isNotEmpty) ...[
          SizedBox(height: 12.h),
          ...attachments.asMap().entries.map(
            (e) => Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colors.grey50,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: colors.grey300),
              ),
              child: Row(
                children: [
                  Icon(Icons.insert_drive_file, color: colors.grey600),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      e.value,
                      style: AppTextStyles.font14Regular.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 20.sp),
                    onPressed: () => onRemoveAttachment(e.key),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class TermsAgreement extends StatelessWidget {
  final bool isAgreed;
  final Function(bool?) onChanged;
  const TermsAgreement({
    super.key,
    required this.isAgreed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isAgreed,
          onChanged: onChanged,
          activeColor: colors.primary800,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I agree to Rafeeq\'s Terms of Service and confirm that this application represents a genuine interest.',
                style: AppTextStyles.font12Regular.copyWith(
                  color: colors.grey700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 4.h),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Terms of Service',
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: colors.primary800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isEnabled;
  const SubmitButton({super.key, required this.onTap, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.grey0,
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .3),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isEnabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary800,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          minimumSize: Size(double.infinity, 52.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Submit Application',
              style: AppTextStyles.font16Bold.copyWith(color: colors.grey0),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_forward, color: colors.grey0, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
