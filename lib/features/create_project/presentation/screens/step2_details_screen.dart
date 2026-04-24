import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart' show EmptyPadding;
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

class Step2DetailsScreen extends StatefulWidget {
  final ProjectDataModel projectData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step2DetailsScreen({
    super.key,
    required this.projectData,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<Step2DetailsScreen> createState() => _Step2DetailsScreenState();
}

class _Step2DetailsScreenState extends State<Step2DetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _useOfFundsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.projectData.description;
    _useOfFundsController.text = widget.projectData.useOfFunds;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _useOfFundsController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      widget.projectData.description = _descriptionController.text.trim();
      widget.projectData.useOfFunds = _useOfFundsController.text.trim();
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
          icon: Icon(Icons.arrow_back_rounded, color: colors.grey600),
          onPressed: widget.onBack,
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
            child: StepProgressBar(currentStep: 2, totalSteps: 4),
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
                          'Step 2 of 4',
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: colors.primary700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 150),
                      child: Text(
                        'Tell your story',
                        style: AppTextStyles.font24Bold.copyWith(
                          color: colors.grey900,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 200),
                      child: Text(
                        'Help investors understand your vision and how you\'ll use their support.',
                        style: AppTextStyles.font14Regular.copyWith(
                          color: colors.grey600,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Description
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 250),
                      child: _FieldLabel(
                        label: 'Project Description',
                        hint: 'Briefly describe your project and its impact',
                        icon: Icons.description_outlined,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 300),
                      child: AppTextFormField(
                        controller: _descriptionController,
                        maxLines: 5,
                        maxLength: 500,
                        textInputAction: TextInputAction.newline,
                        hintText:
                            'e.g. We are building an AI-powered platform that helps retailers optimize their inventory management using predictive analytics...',

                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Required';
                          if (v.trim().length < 20) {
                            return 'Please write at least 20 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Use of Funds
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 350),
                      child: _FieldLabel(
                        label: 'Use of Funds',
                        hint: 'Explain how you will allocate the capital',
                        icon: Icons.account_balance_wallet_outlined,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 400),
                      child: AppTextFormField(
                        controller: _useOfFundsController,
                        maxLines: 4,
                        maxLength: 300,
                        hintText:
                            'e.g. 40% product development, 30% marketing, 20% team hiring, 10% operations...',
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Required';
                          if (v.trim().length < 10) {
                            return 'Please provide more detail';
                          }
                          return null;
                        },
                      ),
                    ),
                    10.h.ph,
                    // Tip card
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 450),
                      child: Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: colors.accent600.withValues(alpha: .08),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: colors.accent600.withValues(alpha: .2),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.tips_and_updates_outlined,
                              size: 18.sp,
                              color: colors.accent600,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                'Projects with clear fund allocation get 3x more investor interest.',
                                style: AppTextStyles.font12Regular.copyWith(
                                  color: colors.grey700,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),

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
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      label: 'Back',
                      icon: Icons.arrow_back_rounded,
                      onPressed: widget.onBack,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      label: 'Continue',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _handleContinue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;

  const _FieldLabel({
    required this.label,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: colors.primary800),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.font14SemiBold.copyWith(
                color: colors.grey900,
              ),
            ),
            Text(
              hint,
              style: AppTextStyles.font12Regular.copyWith(
                color: colors.grey500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
