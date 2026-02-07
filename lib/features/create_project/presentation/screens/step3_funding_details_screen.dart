import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/app_colors/custom_app_colors.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import '../widgets/step_progress_bar.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';
import '../widgets/funding_type_card.dart';

class Step3FundingDetailsScreen extends StatefulWidget {
  final ProjectDataModel projectData;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step3FundingDetailsScreen({
    super.key,
    required this.projectData,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<Step3FundingDetailsScreen> createState() =>
      _Step3FundingDetailsScreenState();
}

class _Step3FundingDetailsScreenState extends State<Step3FundingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _selectedCurrency = 'USD';
  String? _selectedFundingType;

  final List<Map<String, dynamic>> _fundingTypes = [
    {
      'type': 'Equity',
      'description': 'Share ownership in exchange for capital',
      'icon': Icons.pie_chart_outline,
      'color': Color(0xFF2196F3),
    },
    {
      'type': 'Partnership',
      'description': 'Strategic alliance for mutual benefit',
      'icon': Icons.handshake_outlined,
      'color': Color(0xFF4CAF50),
    },
    {
      'type': 'Grant',
      'description': 'Non-repayable funds for specific purposes',
      'icon': Icons.card_giftcard_outlined,
      'color': Color(0xFFFF9800),
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.projectData.requiredFunding > 0) {
      _amountController.text = widget.projectData.requiredFunding.toString();
    }
    _selectedCurrency = widget.projectData.currency;
    _selectedFundingType = widget.projectData.fundingType.isEmpty
        ? null
        : widget.projectData.fundingType;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate() && _selectedFundingType != null) {
      widget.projectData.requiredFunding =
          double.tryParse(_amountController.text) ?? 0;
      widget.projectData.currency = _selectedCurrency;
      widget.projectData.fundingType = _selectedFundingType!;
      widget.onNext();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please complete all required fields'),
          backgroundColor: CustomAppColors.of(context).error500,
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
          icon: Icon(Icons.arrow_back, color: colors.grey900),
          onPressed: widget.onBack,
        ),
        title: Text(
          'Create Project',
          style: AppTextStyles.font18Bold.copyWith(color: colors.grey900),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StepProgressBar(currentStep: 3, totalSteps: 4),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                          color: colors.primary700,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Funding Details',
                      style: AppTextStyles.font24Bold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Specify the capital required to kickstart your vision.',
                      style: AppTextStyles.font14Regular.copyWith(
                        color: colors.grey600,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      'Required Funding Amount',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: colors.grey50,
                            border: Border.all(color: colors.grey300),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: DropdownButton<String>(
                            value: _selectedCurrency,
                            underline: SizedBox(),
                            items: ['USD', 'EUR', 'GBP', 'EGP']
                                .map(
                                  (currency) => DropdownMenuItem(
                                    value: currency,
                                    child: Text(
                                      currency,
                                      style: AppTextStyles.font14SemiBold
                                          .copyWith(color: colors.grey900),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCurrency = value!;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: colors.grey600,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: '0',
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
                            style: AppTextStyles.font16SemiBold.copyWith(
                              color: colors.grey900,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    // Market average indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.accent600.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 16.sp,
                            color: colors.accent600,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Market avg: \$30k-\$50k',
                            style: AppTextStyles.font12Regular.copyWith(
                              color: colors.grey600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Funding Type
                    Text(
                      'Funding Type',
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.grey900,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ..._fundingTypes.map((fundingType) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: FundingTypeCard(
                          type: fundingType['type'],
                          description: fundingType['description'],
                          icon: fundingType['icon'],
                          color: fundingType['color'],
                          isSelected:
                              _selectedFundingType == fundingType['type'],
                          onTap: () {
                            setState(() {
                              _selectedFundingType = fundingType['type'];
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
                  child: SecondaryButton(
                    label: 'Back',
                    icon: Icons.arrow_back,
                    onPressed: widget.onBack,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: PrimaryButton(
                      label: 'Continue to Next Step',
                      icon: Icons.arrow_forward,
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
