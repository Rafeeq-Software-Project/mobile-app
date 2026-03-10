import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/common/widgets/custom_text_form_field.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/founder_account/data/models/founder_profile.dart';
import 'package:rafeeq_app/features/founder_account/data/models/update_founder_profile/update_founder_profile_request.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/get_founder_data/founder_profile_cubit.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/update_founder_profile/update_founder_profile_cubit.dart';
import 'package:rafeeq_app/features/founder_account/presentation/logic/update_founder_profile/update_founder_profile_state.dart';

class UpdateFounderProfileScreen extends StatefulWidget {
  const UpdateFounderProfileScreen({super.key, required this.profile});

  final FounderProfile profile;

  @override
  State<UpdateFounderProfileScreen> createState() =>
      _UpdateFounderProfileScreenState();
}

class _UpdateFounderProfileScreenState
    extends State<UpdateFounderProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final industryController = TextEditingController();
  final websiteController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();
  final bioController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fillForm();
  }

  void fillForm() {
    final profile = widget.profile;

    firstNameController.text = profile.userFirstName;
    lastNameController.text = profile.userLastName;
    companyNameController.text = profile.companyName ?? '';
    industryController.text = profile.industry ?? '';
    websiteController.text = profile.websiteUrl ?? '';
    phoneController.text = profile.phoneNumber ?? '';
    roleController.text = profile.roleTitle ?? '';
    bioController.text = profile.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateFounderProfileCubit, UpdateFounderProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Profile updated successfully"),
                backgroundColor: context.customAppColors.info700,
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.read<FounderProfileCubit>().fetchFounderProfile();
            context.pop();
          },

          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.customAppColors.primary800,
          centerTitle: true,
          title: Text(
            "Edit Founder Profile",
            style: AppTextStyles.font16Regular.copyWith(
              color: context.customAppColors.grey0,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: context.customAppColors.grey0,
              size: 16.sp,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// PERSONAL INFO
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

                24.h.ph,

                /// COMPANY INFO
                Text(
                  "Company Information",
                  style: AppTextStyles.font20Bold.copyWith(
                    color: context.customAppColors.grey900,
                  ),
                ),

                16.h.ph,

                AppTextFormField(
                  hintText: "Company Name",
                  controller: companyNameController,
                ),

                12.h.ph,

                AppTextFormField(
                  hintText: "Industry",
                  controller: industryController,
                ),

                12.h.ph,

                AppTextFormField(
                  hintText: "Role Title",
                  controller: roleController,
                ),

                12.h.ph,

                AppTextFormField(
                  hintText: "Website",
                  controller: websiteController,
                ),

                12.h.ph,

                AppTextFormField(
                  hintText: "Phone Number",
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),

                24.h.ph,

                /// ABOUT
                Text(
                  "About Founder",
                  style: AppTextStyles.font20Bold.copyWith(
                    color: context.customAppColors.grey900,
                  ),
                ),

                16.h.ph,

                AppTextFormField(
                  hintText: "Bio",
                  controller: bioController,
                  maxLines: 4,
                ),

                30.h.ph,

                /// BUTTON
                CustomButton(
                  text: "Update",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final request = UpdateFounderProfileRequest(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        companyName: companyNameController.text,
                        industry: industryController.text,
                        websiteUrl: websiteController.text,
                        phoneNumber: phoneController.text,
                        roleTitle: roleController.text,
                        bio: bioController.text,
                      );

                      context
                          .read<UpdateFounderProfileCubit>()
                          .updateInvestorProfile(request);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
