import 'package:rafeeq_app/core/common/widgets/app_dropdown.dart';
import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/common/widgets/custom_loading.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/investor_account/data/models/investor_profile_model.dart';
import 'package:rafeeq_app/features/investor_account/data/models/update_investor_profile/update_investor_profile_request.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/my_investor_profile/my_investor_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/update_investor_profile/update_investor_profile_cubit.dart';
import 'package:rafeeq_app/features/investor_account/presentation/logic/update_investor_profile/update_investor_profile_state.dart';

class UpdateInvestorProfileScreen extends StatefulWidget {
  const UpdateInvestorProfileScreen({super.key, required this.profile});
  final InvestorProfileModel profile;

  @override
  State<UpdateInvestorProfileScreen> createState() =>
      _UpdateInvestorProfileScreenState();
}

class _UpdateInvestorProfileScreenState
    extends State<UpdateInvestorProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final investorTypeController = TextEditingController();
  final locationController = TextEditingController();
  final minInvestmentController = TextEditingController();
  final maxInvestmentController = TextEditingController();
  final stageController = TextEditingController();
  final interestsController = TextEditingController();
  final bioController = TextEditingController();
  final experienceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedInterests = widget.profile.investmentInterests ?? [];
    fillForm();
  }

  void fillForm() {
    final profile = widget.profile;

    firstNameController.text = profile.userFirstName;
    lastNameController.text = profile.userLastName;
    investorTypeController.text = profile.investorType ?? '';
    locationController.text = profile.location ?? '';
    minInvestmentController.text = profile.minInvestment?.toString() ?? '';
    maxInvestmentController.text = profile.maxInvestment?.toString() ?? '';
    stageController.text = profile.stage ?? '';
    interestsController.text = (profile.investmentInterests ?? []).join(', ');
    bioController.text = profile.bio ?? '';
    experienceController.text = profile.experienceYears?.toString() ?? '';
  }

  final List<String> interestsOptions = [
    "Technology",
    "FinTech",
    "Healthcare",
    "E-commerce",
    "AI",
    "Education",
    "Real Estate",
  ];
  List<String> selectedInterests = [];
  String? selectedInterest;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateInvestorProfileCubit, UpdateInvestorProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (_) => const Center(child: CustomLoading(size: 100)),
            );
          },
          success: (data) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully")),
            );
            context.read<MyInvestorProfileCubit>().fetchInvestorProfile();
            context.pop();
          },
          error: (message) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: context.customAppColors.grey0,
                size: 16.sp,
              ),
            ),
            backgroundColor: context.customAppColors.primary800,
            centerTitle: true,
            title: Text(
              "Edit Investor Profile",
              style: AppTextStyles.font16Regular.copyWith(
                color: context.customAppColors.grey0,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal Information",
                    style: AppTextStyles.font20Bold.copyWith(
                      color: context.customAppColors.grey900,
                    ),
                  ),
                  16.h.ph,
                  AppTextFormField(
                    hintText: "First Name",
                    controller: firstNameController,
                  ),
                  12.h.ph,
                  AppTextFormField(
                    hintText: "Last Name",
                    controller: lastNameController,
                  ),
                  12.h.ph,
                  AppTextFormField(
                    hintText: "Investor Type",
                    controller: investorTypeController,
                  ),
                  12.h.ph,
                  AppTextFormField(
                    hintText: "Location",
                    controller: locationController,
                  ),
                  24.h.ph,
                  Text(
                    "Investment Details",
                    style: AppTextStyles.font20Bold.copyWith(
                      color: context.customAppColors.grey900,
                    ),
                  ),
                  16.h.ph,
                  AppTextFormField(
                    hintText: "Minimum Investment",
                    controller: minInvestmentController,
                    keyboardType: TextInputType.number,
                  ),
                  12.h.ph,
                  AppTextFormField(
                    hintText: "Maximum Investment",
                    controller: maxInvestmentController,
                    keyboardType: TextInputType.number,
                  ),
                  12.h.ph,
                  AppTextFormField(
                    hintText: "Investment Stage",
                    controller: stageController,
                  ),
                  12.h.ph,
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedInterests.map((interest) {
                      return Chip(
                        label: Text(interest),
                        deleteIcon: Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() {
                            selectedInterests.remove(interest);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  AppDropdown<String>(
                    hint: "Add Investment Interest",
                    value: null,
                    items: interestsOptions,
                    labelBuilder: (interest) => interest,
                    onChanged: (value) {
                      if (value != null && !selectedInterests.contains(value)) {
                        setState(() {
                          selectedInterests.add(value);
                        });
                      }
                    },
                  ),
                  24.h.ph,
                  Text(
                    "About Investor",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  16.h.ph,
                  AppTextFormField(
                    hintText: "Bio",
                    controller: bioController,
                    maxLines: 4,
                  ),
                  12.h.ph,
                  AppTextFormField(
                    hintText: "Years of Experience",
                    controller: experienceController,
                    keyboardType: TextInputType.number,
                  ),
                  30.h.ph,
                  CustomButton(
                    text: 'Update',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        final request = UpdateInvestorProfileRequest(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          investorType: investorTypeController.text,
                          location: locationController.text,
                          minInvestment: double.parse(
                            minInvestmentController.text,
                          ),
                          maxInvestment: double.parse(
                            maxInvestmentController.text,
                          ),
                          stage: stageController.text,
                          investmentInterests: selectedInterests.join(','),
                          bio: bioController.text,
                          experienceYears: int.parse(experienceController.text),
                        );

                        context
                            .read<UpdateInvestorProfileCubit>()
                            .updateInvestorProfile(request);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
