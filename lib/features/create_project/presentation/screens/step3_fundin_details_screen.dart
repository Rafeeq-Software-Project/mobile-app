import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

class Step3FundingScreen extends StatefulWidget {
  final ProjectDataModel projectData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step3FundingScreen({
    super.key,
    required this.projectData,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<Step3FundingScreen> createState() => _Step3FundingScreenState();
}

class _Step3FundingScreenState extends State<Step3FundingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  final _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    if (widget.projectData.fundingGoal > 0) {
      _amountController.text = widget.projectData.fundingGoal.toStringAsFixed(
        0,
      );
    }
    if (widget.projectData.startDate.isNotEmpty) {
      _startDate = DateTime.tryParse(widget.projectData.startDate);
    }
    if (widget.projectData.endDate.isNotEmpty) {
      _endDate = DateTime.tryParse(widget.projectData.endDate);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial = isStart
        ? (_startDate ?? now)
        : (_endDate ?? (_startDate?.add(const Duration(days: 30)) ?? now));

    final first = isStart ? now : (_startDate ?? now);
    final last = DateTime(now.year + 5);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(first) ? first : initial,
      firstDate: first,
      lastDate: last,
      builder: (context, child) {
        final colors = context.customAppColors;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colors.primary700,
              onPrimary: colors.white,
              surface: colors.grey0,
              onSurface: colors.grey900,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select start and end dates'),
          backgroundColor: context.customAppColors.error500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      return;
    }

    widget.projectData.fundingGoal =
        double.tryParse(_amountController.text) ?? 0;
    widget.projectData.startDate = _dateFormat.format(_startDate!);
    widget.projectData.endDate = _dateFormat.format(_endDate!);
    widget.onNext();
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
            child: StepProgressBar(currentStep: 3, totalSteps: 4),
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
                          color: colors.primary800.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Step 3 of 4',
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
                        'Funding Details',
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
                        'Specify the capital needed and your project timeline.',
                        style: AppTextStyles.font14Regular.copyWith(
                          color: colors.grey600,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Funding Goal
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 250),
                      child: Text(
                        'Funding Goal (USD)',
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
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Text(
                            '\$',
                            style: AppTextStyles.font18Bold.copyWith(
                              color: colors.grey600,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Required';
                          final amount = double.tryParse(v);
                          if (amount == null || amount <= 0) {
                            return 'Enter a valid amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 320),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.accent600.withValues(alpha: .08),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.trending_up_rounded,
                              size: 16.sp,
                              color: colors.accent600,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Market average: \$30K – \$50K',
                              style: AppTextStyles.font12Regular.copyWith(
                                color: colors.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Dates
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 370),
                      child: Text(
                        'Project Timeline',
                        style: AppTextStyles.font14SemiBold.copyWith(
                          color: colors.grey900,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 410),
                      child: Row(
                        children: [
                          Expanded(
                            child: _DatePickerField(
                              label: 'Start Date',
                              value: _startDate,
                              icon: Icons.play_circle_outline_rounded,
                              onTap: () => _pickDate(isStart: true),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _DatePickerField(
                              label: 'End Date',
                              value: _endDate,
                              icon: Icons.flag_outlined,
                              onTap: () => _pickDate(isStart: false),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Duration preview
                    if (_startDate != null && _endDate != null)
                      FadeInUp(
                        duration: const Duration(milliseconds: 400),
                        child: Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: colors.primary800.withValues(alpha: .06),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: colors.primary800.withValues(alpha: .2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 18.sp,
                                color: colors.primary800,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Duration: ${_endDate!.difference(_startDate!).inDays} days',
                                style: AppTextStyles.font14SemiBold.copyWith(
                                  color: colors.primary800,
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
                      label: 'Review',
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

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final IconData icon;
  final VoidCallback onTap;

  const _DatePickerField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final hasValue = value != null;
    final formatted = hasValue
        ? DateFormat('MMM d, yyyy').format(value!)
        : null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: hasValue
              ? colors.primary800.withValues(alpha: .06)
              : colors.grey50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: hasValue
                ? colors.primary800.withValues(alpha: .4)
                : colors.grey200,
            width: hasValue ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16.sp,
                  color: hasValue ? colors.primary800 : colors.grey400,
                ),
                SizedBox(width: 6.w),
                Text(
                  label,
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: hasValue ? colors.primary800 : colors.grey500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              formatted ?? 'Select date',
              style: hasValue
                  ? AppTextStyles.font14Bold.copyWith(color: colors.grey900)
                  : AppTextStyles.font13Regular.copyWith(color: colors.grey400),
            ),
          ],
        ),
      ),
    );
  }
}
