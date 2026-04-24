import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/create_project/data/models/create_project_request.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import 'package:rafeeq_app/features/create_project/presentation/logic/create_project/create_project_cubit.dart';
import 'package:rafeeq_app/features/create_project/presentation/logic/create_project/create_project_state.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/secondary_button.dart';

class Step4ReviewScreen extends StatelessWidget {
  final ProjectDataModel projectData;
  final VoidCallback
  onNext; // called on success → coordinator navigates to success screen
  final VoidCallback onBack;

  const Step4ReviewScreen({
    super.key,
    required this.projectData,
    required this.onNext,
    required this.onBack,
  });

  void _submit(BuildContext context) {
    final request = CreateProjectRequest(
      name: projectData.name,
      description: projectData.description,
      category: projectData.category,
      fundingGoal: projectData.fundingGoal,
      useOfFunds: projectData.useOfFunds,
      startDate: projectData.startDate,
      endDate: projectData.endDate,
    );
    context.read<CreateProjectCubit>().createProject(request);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return BlocConsumer<CreateProjectCubit, CreateProjectState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) => onNext(),
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: colors.error500,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state == const CreateProjectState.loading();
        return Scaffold(
          backgroundColor: colors.grey0,
          appBar: AppBar(
            backgroundColor: colors.grey0,
            elevation: 0,
            leading: isLoading
                ? null
                : IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: colors.grey600),
                    onPressed: onBack,
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
                child: StepProgressBar(currentStep: 4, totalSteps: 4),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                            'Step 4 of 4',
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
                          'Review & Submit',
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
                          'Everything looks good? Let\'s publish your project.',
                          style: AppTextStyles.font14Regular.copyWith(
                            color: colors.grey600,
                            height: 1.4,
                          ),
                        ),
                      ),
                      SizedBox(height: 28.h),

                      // Review Card
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 250),
                        child: _ReviewCard(
                          title: 'Project Basics',
                          icon: Icons.info_outline_rounded,
                          items: [
                            _ReviewItem(label: 'Name', value: projectData.name),
                            _ReviewItem(
                              label: 'Category',
                              value: projectData.category,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 320),
                        child: _ReviewCard(
                          title: 'Project Details',
                          icon: Icons.description_outlined,
                          items: [
                            _ReviewItem(
                              label: 'Description',
                              value: projectData.description,
                              isMultiline: true,
                            ),
                            _ReviewItem(
                              label: 'Use of Funds',
                              value: projectData.useOfFunds,
                              isMultiline: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: const Duration(milliseconds: 390),
                        child: _ReviewCard(
                          title: 'Funding',
                          icon: Icons.account_balance_wallet_outlined,
                          items: [
                            _ReviewItem(
                              label: 'Funding Goal',
                              value:
                                  '\$${projectData.fundingGoal.toStringAsFixed(0)}',
                              highlight: true,
                            ),
                            _ReviewItem(
                              label: 'Start Date',
                              value: projectData.startDate,
                            ),
                            _ReviewItem(
                              label: 'End Date',
                              value: projectData.endDate,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                    ],
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
                  child: Column(
                    children: [
                      _SubmitButton(
                        isLoading: isLoading,
                        onPressed: isLoading ? null : () => _submit(context),
                      ),
                      if (!isLoading) ...[
                        SizedBox(height: 12.h),
                        SecondaryButton(
                          label: 'Back to Edit',
                          icon: Icons.edit_outlined,
                          onPressed: onBack,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<_ReviewItem> items;

  const _ReviewCard({
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.grey0,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.grey200),
        boxShadow: [
          BoxShadow(
            color: colors.grey300.withValues(alpha: .15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colors.grey50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              border: Border(bottom: BorderSide(color: colors.grey200)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18.sp, color: colors.primary800),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: AppTextStyles.font14Bold.copyWith(
                    color: colors.grey800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: items
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(
                        bottom: items.last != item ? 12.h : 0,
                      ),
                      child: item,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isMultiline;
  final bool highlight;

  const _ReviewItem({
    required this.label,
    required this.value,
    this.isMultiline = false,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Row(
      crossAxisAlignment: isMultiline
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: AppTextStyles.font12Regular.copyWith(color: colors.grey500),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value.isEmpty ? '—' : value,
            style: highlight
                ? AppTextStyles.font16Bold.copyWith(color: colors.primary800)
                : AppTextStyles.font14SemiBold.copyWith(
                    color: colors.grey800,
                    height: 1.4,
                  ),
            maxLines: isMultiline ? 3 : 1,
            overflow: isMultiline
                ? TextOverflow.ellipsis
                : TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _SubmitButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLoading
                ? [colors.grey300, colors.grey300]
                : [colors.primary800, colors.accent600],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: isLoading
              ? []
              : [
                  BoxShadow(
                    color: colors.primary700.withValues(alpha: .35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(colors.white),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Publishing...',
                      style: AppTextStyles.font16SemiBold.copyWith(
                        color: colors.white,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.rocket_launch_rounded,
                      color: colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Publish Project',
                      style: AppTextStyles.font16SemiBold.copyWith(
                        color: colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
