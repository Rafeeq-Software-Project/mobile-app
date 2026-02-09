import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/features/rate_founder/data/models/rate_founder_model.dart';
import 'package:rafeeq_app/features/rate_founder/presentation/widgets/rate_widgets.dart';

class RateFounderScreen extends StatefulWidget {
  const RateFounderScreen({super.key});

  @override
  State<RateFounderScreen> createState() => _RateFounderScreenState();
}

class _RateFounderScreenState extends State<RateFounderScreen> {
  late RateFounderModel founder;
  int selectedRating = 0;
  String selectedExperienceTag = '';
  Set<String> selectedTags = {};
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    founder = RateFounderModel.sample();
  }

  void _onRatingChanged(int rating) {
    setState(() {
      selectedRating = rating;
      // Auto-select experience tag based on rating
      if (rating >= 4) {
        selectedExperienceTag = 'Good experience';
      } else if (rating >= 2) {
        selectedExperienceTag = 'Neutral';
      } else if (rating > 0) {
        selectedExperienceTag = 'Poor experience';
      }
    });
  }

  void _onExperienceTagSelected(String tag) {
    setState(() {
      selectedExperienceTag = tag;
    });
  }

  void _onTagToggle(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  void _submitReview() {
    if (selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a rating'),
          backgroundColor: CustomAppColors.of(context).error500,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Review submitted successfully!'),
        backgroundColor: CustomAppColors.of(context).accent600,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);

    return Scaffold(
      backgroundColor: colors.grey0,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            RateAppBar(onBackTap: () => Navigator.pop(context)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    RateHeader(),
                    SizedBox(height: 20.h),

                    // Founder Profile Card
                    FounderProfileCard(
                      name: founder.founderName,
                      role: founder.role,
                      imageUrl: founder.imageUrl,
                      collaborationDate: founder.collaborationDate,
                    ),
                    SizedBox(height: 24.h),

                    // Experience Question
                    ExperienceQuestion(),
                    SizedBox(height: 16.h),

                    // Rating Stars
                    RatingStars(
                      rating: selectedRating,
                      onRatingChanged: _onRatingChanged,
                    ),
                    SizedBox(height: 16.h),

                    // Experience Tags
                    ExperienceTags(
                      selectedTag: selectedExperienceTag,
                      onTagSelected: _onExperienceTagSelected,
                      selectedDetailTags: selectedTags,
                      onDetailTagToggle: _onTagToggle,
                    ),
                    SizedBox(height: 24.h),

                    // Review Text Field
                    ReviewTextField(controller: _reviewController),
                    SizedBox(height: 80.h), // Space for button
                  ],
                ),
              ),
            ),

            // Submit Button
            SubmitReviewButton(onTap: _submitReview),
          ],
        ),
      ),
    );
  }
}
