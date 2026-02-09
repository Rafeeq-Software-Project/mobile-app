import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';

class RateAppBar extends StatelessWidget {
  final VoidCallback onBackTap;
  const RateAppBar({super.key, required this.onBackTap});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
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
            'Rate Founder',
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
          ),
        ],
      ),
    );
  }
}

class RateHeader extends StatelessWidget {
  const RateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review your partnership',
          style: AppTextStyles.font20Bold.copyWith(color: colors.grey900),
        ),
        SizedBox(height: 4.h),
        Text(
          'Your feedback helps the Rafeeq community connect with trusted founders.',
          style: AppTextStyles.font14Regular.copyWith(
            color: colors.grey600,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class FounderProfileCard extends StatelessWidget {
  final String name, role, imageUrl, collaborationDate;
  const FounderProfileCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.collaborationDate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: colors.grey50,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .2),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundImage: NetworkImage(imageUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: colors.grey0,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: colors.accent600,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            name,
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.business_center, size: 14.sp, color: colors.grey600),
              SizedBox(width: 4.w),
              Text(
                role,
                style: AppTextStyles.font13Regular.copyWith(
                  color: colors.grey600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today, size: 14.sp, color: colors.grey600),
              SizedBox(width: 4.w),
              Text(
                collaborationDate,
                style: AppTextStyles.font12Regular.copyWith(
                  color: colors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExperienceQuestion extends StatelessWidget {
  const ExperienceQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Text(
      'How was your experience?',
      style: AppTextStyles.font16Bold.copyWith(color: colors.grey900),
    );
  }
}

class RatingStars extends StatelessWidget {
  final int rating;
  final Function(int) onRatingChanged;
  const RatingStars({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRatingChanged(index + 1),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Icon(
              index < rating ? Icons.star : Icons.star_border,
              size: 40.sp,
              color: index < rating ? colors.warning500 : colors.grey400,
            ),
          ),
        );
      }),
    );
  }
}

class ExperienceTags extends StatelessWidget {
  final String selectedTag;
  final Function(String) onTagSelected;
  final Set<String> selectedDetailTags;
  final Function(String) onDetailTagToggle;
  const ExperienceTags({
    super.key,
    required this.selectedTag,
    required this.onTagSelected,
    required this.selectedDetailTags,
    required this.onDetailTagToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    final experienceTags = ['Good experience', 'Neutral', 'Poor experience'];
    final detailTags = [
      'Clear Communication',
      'Professionalism',
      'Timely Updates',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Experience tags
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.w,
          children: experienceTags.map((tag) {
            final isSelected = tag == selectedTag;
            return GestureDetector(
              onTap: () => onTagSelected(tag),
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary800.withValues(alpha: .1)
                      : colors.grey100,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? colors.primary800 : colors.grey300,
                  ),
                ),
                child: Text(
                  tag,
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: isSelected ? colors.primary800 : colors.grey700,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16.h),
        // Detail tags
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.w,
          runSpacing: 8.h,
          children: detailTags.map((tag) {
            final isSelected = selectedDetailTags.contains(tag);
            return GestureDetector(
              onTap: () => onDetailTagToggle(tag),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary800 : colors.grey0,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: colors.grey300),
                ),
                child: Text(
                  tag,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: isSelected ? colors.grey0 : colors.grey700,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ReviewTextField extends StatelessWidget {
  final TextEditingController controller;
  const ReviewTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Write a review',
              style: AppTextStyles.font16Bold.copyWith(color: colors.grey900),
            ),
            SizedBox(width: 8.w),
            Text(
              '(Optional)',
              style: AppTextStyles.font14Regular.copyWith(
                color: colors.grey500,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: colors.grey50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colors.grey300),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  'Share specific details about what went well or could be improved...',
              hintStyle: AppTextStyles.font14Regular.copyWith(
                color: colors.grey400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
            ),
          ),
        ),
      ],
    );
  }
}

class SubmitReviewButton extends StatelessWidget {
  final VoidCallback onTap;
  const SubmitReviewButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
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
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary800,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          minimumSize: Size(double.infinity, 52.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Submit Review',
          style: AppTextStyles.font16Bold.copyWith(color: colors.grey0),
        ),
      ),
    );
  }
}
