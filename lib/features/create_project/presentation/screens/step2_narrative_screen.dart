import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';
import '../widgets/expandable_text_field.dart';

class Step2NarrativeScreen extends StatefulWidget {
  final ProjectDataModel projectData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step2NarrativeScreen({
    super.key,
    required this.projectData,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<Step2NarrativeScreen> createState() => _Step2NarrativeScreenState();
}

class _Step2NarrativeScreenState extends State<Step2NarrativeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _problemController = TextEditingController();
  final _solutionController = TextEditingController();
  final _targetMarketController = TextEditingController();
  final _tagController = TextEditingController();

  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _problemController.text = widget.projectData.problemStatement;
    _solutionController.text = widget.projectData.solutionDescription;
    _targetMarketController.text = widget.projectData.targetMarket;
    _tags = List.from(widget.projectData.tags);
  }

  @override
  void dispose() {
    _problemController.dispose();
    _solutionController.dispose();
    _targetMarketController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _addTag() {
    if (_tagController.text.isNotEmpty) {
      setState(() {
        _tags.add(_tagController.text);
        _tagController.clear();
      });
    }
  }

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      widget.projectData.problemStatement = _problemController.text;
      widget.projectData.solutionDescription = _solutionController.text;
      widget.projectData.targetMarket = _targetMarketController.text;
      widget.projectData.tags = _tags;
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.grey0,
      appBar: AppBar(
        backgroundColor: colors.grey0,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.grey900),
          onPressed: widget.onBack,
        ),
        title: Text(
          'Create Project',
          style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: AppTextStyles.font14SemiBold.copyWith(
                color: colors.grey500,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          StepProgressBar(currentStep: 2, totalSteps: 4),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step 2 of 4',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.grey600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Project Narrative',
                      style: AppTextStyles.font24Bold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Tell us the story behind your idea. What problem are you solving and for whom?',
                      style: AppTextStyles.font14Regular.copyWith(
                        color: colors.grey600,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Problem Statement
                    ExpandableTextField(
                      label: 'Problem Statement',
                      controller: _problemController,
                      hintText:
                          'Describe the pain point your work will solve. E.g., "Small businesses struggle to manage inventory tracker that exceeds those limits."',
                      maxLines: 5,
                      maxCharacters: 500,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please describe the problem';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Solution Description
                    ExpandableTextField(
                      label: 'Solution Description',
                      controller: _solutionController,
                      hintText:
                          'How does your product solve this problem? E.g., "Our AI-powered inventory tracker that exceeds those limits."',
                      maxLines: 5,
                      maxCharacters: 500,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please describe your solution';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Text(
                          'Target Market',
                          style: AppTextStyles.font14SemiBold.copyWith(
                            color: colors.grey900,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.grey200,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.help_outline,
                                size: 14.sp,
                                color: colors.grey600,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Optional',
                                style: AppTextStyles.font12Regular.copyWith(
                                  color: colors.grey600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _targetMarketController,
                      decoration: InputDecoration(
                        hintText:
                            'Who are your ideal customers? E.g., "retailers with 1-10 employees..."',
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
                          borderSide: BorderSide(
                            color: colors.primary700,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Chip(
                            label: Text(
                              'Local',
                              style: AppTextStyles.font12SemiBold.copyWith(
                                color: colors.primary700,
                              ),
                            ),
                            backgroundColor: colors.primary300.withValues(
                              alpha: .2,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Tags
                    Text(
                      'Tags',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _tagController,
                            decoration: InputDecoration(
                              hintText: 'Add tags',
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
                                borderSide: BorderSide(
                                  color: colors.primary700,
                                  width: 2,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                            ),
                            onFieldSubmitted: (_) => _addTag(),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: BoxDecoration(
                            color: colors.grey200,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, color: colors.grey700),
                            onPressed: _addTag,
                          ),
                        ),
                      ],
                    ),
                    if (_tags.isNotEmpty) ...[
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _tags.asMap().entries.map((entry) {
                          return Chip(
                            label: Text(
                              entry.value,
                              style: AppTextStyles.font12SemiBold.copyWith(
                                color: colors.grey800,
                              ),
                            ),
                            backgroundColor: colors.grey200,
                            deleteIcon: Icon(
                              Icons.close,
                              size: 16.sp,
                              color: colors.grey600,
                            ),
                            onDeleted: () => _removeTag(entry.key),
                          );
                        }).toList(),
                      ),
                    ],
                    SizedBox(height: 12.h),
                    // Suggested tags
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: ['Investors', 'Inventory', 'Add Tag'].map((
                        tag,
                      ) {
                        return InkWell(
                          onTap: () {
                            if (tag != 'Add Tag' && !_tags.contains(tag)) {
                              setState(() {
                                _tags.add(tag);
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: colors.grey300),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              tag,
                              style: AppTextStyles.font12Regular.copyWith(
                                color: colors.grey600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: colors.grey0,
              boxShadow: [
                BoxShadow(
                  color: colors.grey300.withValues(alpha: .3),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SecondaryButton(
                    label: 'Back',
                    icon: Icons.arrow_back,
                    onPressed: widget.onBack,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: PrimaryButton(
                      label: 'Continue',
                      onPressed: _handleContinue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
