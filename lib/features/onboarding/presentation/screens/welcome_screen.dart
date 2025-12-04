import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/common/widgets/custom_button.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/core/utils/app_images.dart';
import 'package:rafeeq_app/generated/l10n.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: fadeController, curve: Curves.easeOut));

    fadeController.forward();
  }

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
  }

  void animateText() {
    fadeController.reset();
    fadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                width: double.infinity,
                child: Image.asset(AppImages.onboarding5, fit: BoxFit.fill),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 260.h,
                padding: EdgeInsets.all(25.h),
                decoration: BoxDecoration(
                  color: context.customAppColors.grey0,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: fadeAnimation,
                      child: SlideTransition(
                        position: slideAnimation,
                        child: Column(
                          children: [
                            20.h.ph,
                            Text(
                              S.of(context).welcome_title,
                              style: AppTextStyles.font24Bold.copyWith(
                                color: context.customAppColors.grey900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            15.h.ph,
                            Text(
                              S.of(context).welcome_subtitle,
                              style: AppTextStyles.font16Regular.copyWith(
                                color: context.customAppColors.grey600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: S.of(context).welcome_button_start,
                      onTap: () {
                        GoRouter.of(context).pushReplacement(Routes.login);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
