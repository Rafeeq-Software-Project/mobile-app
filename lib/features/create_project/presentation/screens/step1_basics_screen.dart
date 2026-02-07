import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/stage_selection_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/image_upload_card.dart';

class Step1BasicsScreen extends StatefulWidget {
  final ProjectDataModel projectData;
  final VoidCallback onNext;

  const Step1BasicsScreen({
    super.key,
    required this.projectData,
    required this.onNext,
  });

  @override
  State<Step1BasicsScreen> createState() => _Step1BasicsScreenState();
}

class _Step1BasicsScreenState extends State<Step1BasicsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _selectedCategory;
  String? _selectedStage;

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Technology', 'icon': Icons.computer},
    {'label': 'Healthcare', 'icon': Icons.medical_services},
    {'label': 'Education', 'icon': Icons.school},
    {'label': 'Agriculture', 'icon': Icons.eco},
    {'label': 'Finance', 'icon': Icons.account_balance},
    {'label': 'Other', 'icon': Icons.category},
  ];

  final List<Map<String, dynamic>> _stages = [
    {
      'title': 'Idea',
      'subtitle': 'Just a concept, looking for validation',
      'icon': Icons.lightbulb_outline,
      'color': Color(0xFFFFA726),
    },
    {
      'title': 'MVP',
      'subtitle': 'Prototype ready, early testing',
      'icon': Icons.construction,
      'color': Color(0xFF42A5F5),
    },
    {
      'title': 'Scaling',
      'subtitle': 'Revenue generating, looking to grow',
      'icon': Icons.trending_up,
      'color': Color(0xFF66BB6A),
    },
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.projectData.projectName;
    _selectedCategory = widget.projectData.category.isEmpty
        ? null
        : widget.projectData.category;
    _selectedStage = widget.projectData.currentStage.isEmpty
        ? null
        : widget.projectData.currentStage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate() &&
        _selectedCategory != null &&
        _selectedStage != null) {
      widget.projectData.projectName = _nameController.text;
      widget.projectData.category = _selectedCategory!;
      widget.projectData.currentStage = _selectedStage!;
      widget.onNext();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: context.customAppColors.error500,
        ),
      );
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
          icon: Icon(Icons.arrow_back, color: colors.grey600),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Project',
          style: AppTextStyles.font18Bold.copyWith(color: colors.grey800),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Bar
          StepProgressBar(currentStep: 1, totalSteps: 4),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover Image
                    ImageUploadCard(
                      imagePath: widget.projectData.coverImagePath,
                      onImageSelected: (path) {
                        setState(() {
                          widget.projectData.coverImagePath = path;
                        });
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Section Title
                    Text(
                      'Let\'s start with the basics',
                      style: AppTextStyles.font24Bold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Tell us a little about what you are building to help us find the right matches.',
                      style: AppTextStyles.font14Regular.copyWith(
                        color: colors.grey600,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Project Name
                    Text(
                      'Project Name',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'e.g. RetailAI',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a project name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Industry/Category
                    Text(
                      'Industry/Category',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        hintText: 'Select a category',
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
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['label'],
                          child: Row(
                            children: [
                              Icon(
                                category['icon'],
                                size: 20.sp,
                                color: colors.grey600,
                              ),
                              SizedBox(width: 12.w),
                              Text(category['label']),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Current Stage
                    Text(
                      'Current Stage',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ..._stages.map((stage) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: StageSelectionCard(
                          title: stage['title'],
                          subtitle: stage['subtitle'],
                          icon: stage['icon'],
                          color: stage['color'],
                          isSelected: _selectedStage == stage['title'],
                          onTap: () {
                            setState(() {
                              _selectedStage = stage['title'];
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Button
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
            child: PrimaryButton(
              label: 'Continue to Description',
              onPressed: _handleContinue,
            ),
          ),
        ],
      ),
    );
  }
}
