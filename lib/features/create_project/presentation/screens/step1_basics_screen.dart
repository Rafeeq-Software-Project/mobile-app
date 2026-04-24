import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/primary_button.dart';

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

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Technology', 'icon': Icons.computer_rounded},
    {'label': 'Healthcare', 'icon': Icons.medical_services_rounded},
    {'label': 'Education', 'icon': Icons.school_rounded},
    {'label': 'Agriculture', 'icon': Icons.eco_rounded},
    {'label': 'Finance', 'icon': Icons.account_balance_rounded},
    {'label': 'Other', 'icon': Icons.category_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.projectData.name;
    _selectedCategory = widget.projectData.category.isEmpty
        ? null
        : widget.projectData.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      widget.projectData.name = _nameController.text.trim();
      widget.projectData.category = _selectedCategory!;
      widget.onNext();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: context.customAppColors.error500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
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
          icon: Icon(Icons.close_rounded, color: colors.grey600),
          onPressed: () => Navigator.pop(context),
        ),
        title: FadeInDown(
          duration: const Duration(milliseconds: 400),
          child: Text(
            'Create Project',
            style: AppTextStyles.font18Bold.copyWith(color: colors.grey800),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: StepProgressBar(currentStep: 1, totalSteps: 4),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 28.h),

                    // Header
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 100),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary700.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Step 1 of 4',
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: colors.primary800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 150),
                      child: Text(
                        'Let\'s start with\nthe basics',
                        style: AppTextStyles.font24Bold.copyWith(
                          color: colors.grey900,
                          height: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        'Tell us a little about what you\'re building.',
                        style: AppTextStyles.font14Regular.copyWith(
                          color: colors.grey600,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Project Name
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 250),
                      child: Text(
                        'Project Name',
                        style: AppTextStyles.font14SemiBold.copyWith(
                          color: colors.grey900,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 300),
                      child: AppTextFormField(
                        controller: _nameController,
                        hintText: 'Enter your project name',
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Category
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 350),
                      child: Text(
                        'Industry / Category',
                        style: AppTextStyles.font14SemiBold.copyWith(
                          color: colors.grey900,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 2.4,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected = _selectedCategory == cat['label'];

                        return FadeInUp(
                          duration: const Duration(milliseconds: 400),
                          delay: Duration(milliseconds: 350 + index * 60),
                          child: _CategoryChip(
                            label: cat['label'],
                            icon: cat['icon'],
                            isSelected: isSelected,
                            onTap: () => setState(
                              () => _selectedCategory = cat['label'],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),

          // Bottom
          FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 400),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: colors.grey0,
                boxShadow: [
                  BoxShadow(
                    color: colors.grey300.withValues(alpha: .3),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: PrimaryButton(
                label: 'Continue',
                icon: Icons.arrow_forward_rounded,
                onPressed: _handleContinue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected
            ? colors.primary800.withValues(alpha: .08)
            : colors.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? colors.primary800 : colors.grey200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary800.withValues(alpha: .15)
                      : colors.grey100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  size: 16.sp,
                  color: isSelected ? colors.primary800 : colors.grey500,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: isSelected ? colors.primary800 : colors.grey700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  size: 16.sp,
                  color: colors.primary800,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
