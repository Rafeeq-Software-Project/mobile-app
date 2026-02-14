import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/common/widgets/social_button.dart';
import 'package:rafeeq_app/core/helpers/app_regex.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/utils/app_icons.dart';
import 'package:rafeeq_app/features/auth/sign_up/data/models/register_request_model.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/logic/register_cubit/register_cubit.dart';
import 'package:rafeeq_app/features/auth/sign_up/presentation/widgets/signup_bloc_listener.dart';
import 'package:rafeeq_app/generated/l10n.dart';
import 'register_header.dart';
import 'register_input.dart';
import 'role_card.dart';
import 'register_divider.dart';
import 'register_login_text.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final first = TextEditingController();
  final last = TextEditingController();
  final user = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  int? roleId;
  bool obscure = true;

  @override
  void dispose() {
    first.dispose();
    last.dispose();
    user.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const RegisterHeader(),
              30.h.ph,

              Row(
                children: [
                  Expanded(
                    child: RegisterInput(controller: first, hint: "First Name"),
                  ),
                  12.w.pw,
                  Expanded(
                    child: RegisterInput(controller: last, hint: "Last Name"),
                  ),
                ],
              ),

              15.h.ph,
              RegisterInput(controller: user, hint: "Username"),

              15.h.ph,
              RegisterInput(
                controller: email,
                hint: "Email",
                keyboard: TextInputType.emailAddress,
                validator: (v) {
                  if (v!.isEmpty) return "Required";
                  if (!AppRegex.isEmailValid(v)) return "Invalid email";
                  return null;
                },
              ),

              15.h.ph,
              RegisterInput(
                controller: pass,
                hint: "Password",
                obscure: obscure,
                suffix: IconButton(
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => obscure = !obscure),
                ),
              ),

              20.h.ph,

              Row(
                children: [
                  Expanded(
                    child: RoleCard(
                      title: "Founder",
                      icon: Icons.rocket_launch,
                      selected: roleId == 2,
                      onTap: () => setState(() => roleId = 2),
                    ),
                  ),
                  15.w.pw,
                  Expanded(
                    child: RoleCard(
                      title: "Investor",
                      icon: Icons.trending_up,
                      selected: roleId == 3,
                      onTap: () => setState(() => roleId = 3),
                    ),
                  ),
                ],
              ),

              25.h.ph,

              CustomButton(text: "Sign Up", onTap: _register),
              25.h.ph,
              const RegisterDivider(),
              20.h.ph,
              SocialButton(
                text: S.of(context).login_google_signin,
                iconPath: AppIcons.googleIcon,
                onTap: () {},
              ),
              10.h.ph,
              SocialButton(
                text: S.of(context).login_facebook_signin,
                iconPath: AppIcons.facebookIcon,
                onTap: () {},
              ),
              const SignupBlocListener(),

              20.h.ph,
              const RegisterLoginText(),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    if (roleId == null) return;

    context.read<RegisterCubit>().register(
      RegisterRequestModel(
        email: email.text.trim(),
        password: pass.text.trim(),
        username: user.text.trim(),
        firstName: first.text.trim(),
        lastName: last.text.trim(),
        roleId: roleId!,
      ),
    );
  }
}
