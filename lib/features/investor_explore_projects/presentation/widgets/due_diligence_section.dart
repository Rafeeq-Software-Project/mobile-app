import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import '../../data/models/explore_project_model.dart';

class DueDiligenceSection extends StatelessWidget {
  final List<DocumentModel> documents;
  const DueDiligenceSection({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Due Diligence',
            style: AppTextStyles.font18SemiBold.copyWith(color: colors.grey900),
          ),
          SizedBox(height: 12.h),
          ...documents.map(
            (doc) => Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: colors.grey50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.grey200),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: _getDocColor(doc.color, colors),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      doc.icon == 'pdf'
                          ? Icons.picture_as_pdf
                          : Icons.table_chart,
                      color: colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.title,
                          style: AppTextStyles.font14Bold.copyWith(
                            color: colors.grey900,
                          ),
                        ),
                        Text(
                          doc.subtitle,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: colors.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.download_outlined, color: colors.grey700),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDocColor(String color, CustomAppColors colors) {
    if (color == 'red') return Colors.red;
    if (color == 'green') return Colors.green;
    return colors.primary700;
  }
}
