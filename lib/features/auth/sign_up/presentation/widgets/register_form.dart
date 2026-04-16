import 'package:animate_do/animate_do.dart';
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
                    child: FadeInLeft(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                      child: RegisterInput(
                        controller: first,
                        hint: "First Name",
                      ),
                    ),
                  ),
                  12.w.pw,
                  Expanded(
                    child: FadeInRight(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                      child: RegisterInput(controller: last, hint: "Last Name"),
                    ),
                  ),
                ],
              ),

              15.h.ph,

              FadeInLeft(
                delay: const Duration(milliseconds: 350),
                duration: const Duration(milliseconds: 500),
                child: RegisterInput(controller: user, hint: "Username"),
              ),

              15.h.ph,

              FadeInRight(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 500),
                child: RegisterInput(
                  controller: email,
                  hint: "Email",
                  keyboard: TextInputType.emailAddress,
                  validator: (v) {
                    if (v!.isEmpty) return "Required";
                    if (!AppRegex.isEmailValid(v)) return "Invalid email";
                    return null;
                  },
                ),
              ),

              15.h.ph,

              FadeInLeft(
                delay: const Duration(milliseconds: 650),
                duration: const Duration(milliseconds: 500),
                child: RegisterInput(
                  controller: pass,
                  hint: "Password",
                  obscure: obscure,
                  suffix: IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => obscure = !obscure),
                  ),
                ),
              ),

              20.h.ph,

              FadeInUp(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 500),
                child: Row(
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
              ),

              25.h.ph,

              ElasticIn(
                delay: const Duration(milliseconds: 950),
                duration: const Duration(milliseconds: 600),
                child: CustomButton(text: "Sign Up", onTap: _register),
              ),

              25.h.ph,

              FadeIn(
                delay: const Duration(milliseconds: 1100),
                child: const RegisterDivider(),
              ),

              20.h.ph,

              FadeInUp(
                delay: const Duration(milliseconds: 1100),
                child: SocialButton(
                  text: S.of(context).login_google_signin,
                  iconPath: AppIcons.googleIcon,
                  onTap: () {},
                ),
              ),

              10.h.ph,

              FadeInUp(
                delay: const Duration(milliseconds: 1250),
                child: SocialButton(
                  text: S.of(context).login_facebook_signin,
                  iconPath: AppIcons.facebookIcon,
                  onTap: () {},
                ),
              ),

              const SignupBlocListener(),

              20.h.ph,

              FadeInUp(
                delay: const Duration(milliseconds: 1500),
                child: const RegisterLoginText(),
              ),
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
