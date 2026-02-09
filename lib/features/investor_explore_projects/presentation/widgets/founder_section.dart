import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_explore_projects/data/models/explore_project_model.dart';

class FounderSection extends StatelessWidget {
  final FounderDetailModel founder;
  const FounderSection({super.key, required this.founder});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Meet the Founder',
                style: AppTextStyles.font18SemiBold.copyWith(
                  color: colors.grey900,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View Profile',
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: colors.primary800,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundImage: NetworkImage(founder.imageUrl),
                  ),
                  if (founder.isVerified)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified,
                          size: 16.sp,
                          color: colors.primary700,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    founder.name,
                    style: AppTextStyles.font16Bold.copyWith(
                      color: colors.grey900,
                    ),
                  ),
                  Text(
                    founder.title,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: colors.grey600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
