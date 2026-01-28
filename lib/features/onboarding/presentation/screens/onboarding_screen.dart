import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/helpers/extensions.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:rafeeq_app/core/theme/app_texts/app_text_styles.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/core/utils/app_images.dart';
import 'package:rafeeq_app/generated/l10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController controller = PageController();
  int index = 0;

  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  final pages = [
    {
      "title": "onboarding_founder_title",
      "subtitle": "onboarding_founder_subtitle",
      "img": AppImages.onboarding1,
    },
    {
      "title": "onboarding_volunteer_title",
      "subtitle": "onboarding_volunteer_subtitle",
      "img": AppImages.onboarding2,
    },
    {
      "title": "onboarding_investor_title",
      "subtitle": "onboarding_investor_subtitle",
      "img": AppImages.onboarding3,
    },
    {
      "title": "onboarding_seeker_title",
      "subtitle": "onboarding_seeker_subtitle",
      "img": AppImages.onboarding4,
    },
  ];

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
    controller.dispose();
    fadeController.dispose();
    super.dispose();
  }

  void animateText() {
    fadeController.reset();
    fadeController.forward();
  }

  String getText(String key) {
    switch (key) {
      case "onboarding_founder_title":
        return S.of(context).onboarding_founder_title;
      case "onboarding_founder_subtitle":
        return S.of(context).onboarding_founder_subtitle;
      case "onboarding_volunteer_title":
        return S.of(context).onboarding_volunteer_title;
      case "onboarding_volunteer_subtitle":
        return S.of(context).onboarding_volunteer_subtitle;
      case "onboarding_investor_title":
        return S.of(context).onboarding_investor_title;
      case "onboarding_investor_subtitle":
        return S.of(context).onboarding_investor_subtitle;
      case "onboarding_seeker_title":
        return S.of(context).onboarding_seeker_title;
      case "onboarding_seeker_subtitle":
        return S.of(context).onboarding_seeker_subtitle;
      default:
        return "";
    }
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
                height: MediaQuery.of(context).size.height * 0.65,
                width: double.infinity,
                child: Image.asset(
                  pages[index]["img"] as String,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).pushReplacement(Routes.navbar);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    S.of(context).skip,
                    style: AppTextStyles.font16Bold.copyWith(
                      color: context.customAppColors.grey0,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 330.h,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: fadeAnimation,
                      child: SlideTransition(
                        position: slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            25.h.ph,
                            Text(
                              getText(pages[index]["title"] as String),
                              style: AppTextStyles.font24Bold.copyWith(
                                color: context.customAppColors.grey900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            15.h.ph,
                            Text(
                              getText(pages[index]["subtitle"] as String),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: controller,
                          count: pages.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: context.customAppColors.primary800,
                            dotHeight: 8.h,
                            dotWidth: 8.w,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            if (index == pages.length - 1) {
                              GoRouter.of(
                                context,
                              ).pushReplacement(Routes.welcome);
                            } else {
                              controller.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.ease,
                              );
                            }
                          },
                          child: Container(
                            width: 55.w,
                            height: 55.h,
                            decoration: BoxDecoration(
                              color: context.customAppColors.primary800,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: context.customAppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /// PageView
      bottomSheet: SizedBox(
        height: 0,
        child: PageView.builder(
          controller: controller,
          itemCount: pages.length,
          onPageChanged: (i) {
            setState(() => index = i);
            animateText();
          },
          itemBuilder: (context, i) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
