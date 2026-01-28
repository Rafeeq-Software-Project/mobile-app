// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Projects`
  String get projects {
    return Intl.message('Projects', name: 'projects', desc: '', args: []);
  }

  /// `Chat`
  String get chat {
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Bring your ideas to life`
  String get onboarding_founder_title {
    return Intl.message(
      'Bring your ideas to life',
      name: 'onboarding_founder_title',
      desc: '',
      args: [],
    );
  }

  /// `Turn your vision into a reality with support from the right network.`
  String get onboarding_founder_subtitle {
    return Intl.message(
      'Turn your vision into a reality with support from the right network.',
      name: 'onboarding_founder_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Make a Difference`
  String get onboarding_volunteer_title {
    return Intl.message(
      'Make a Difference',
      name: 'onboarding_volunteer_title',
      desc: '',
      args: [],
    );
  }

  /// `Use your skills to help exciting projects grow.`
  String get onboarding_volunteer_subtitle {
    return Intl.message(
      'Use your skills to help exciting projects grow.',
      name: 'onboarding_volunteer_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Invest in Innovation`
  String get onboarding_investor_title {
    return Intl.message(
      'Invest in Innovation',
      name: 'onboarding_investor_title',
      desc: '',
      args: [],
    );
  }

  /// `Discover the next big startup and grow with them.`
  String get onboarding_investor_subtitle {
    return Intl.message(
      'Discover the next big startup and grow with them.',
      name: 'onboarding_investor_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Things Done`
  String get onboarding_seeker_title {
    return Intl.message(
      'Get Things Done',
      name: 'onboarding_seeker_title',
      desc: '',
      args: [],
    );
  }

  /// `Find skilled professionals to complete your projects efficiently.`
  String get onboarding_seeker_subtitle {
    return Intl.message(
      'Find skilled professionals to complete your projects efficiently.',
      name: 'onboarding_seeker_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Where visionaries unite`
  String get welcome_title {
    return Intl.message(
      'Where visionaries unite',
      name: 'welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Join the leading network for ambitious minds to grow and succeed.`
  String get welcome_subtitle {
    return Intl.message(
      'Join the leading network for ambitious minds to grow and succeed.',
      name: 'welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get welcome_button_start {
    return Intl.message(
      'Get Started',
      name: 'welcome_button_start',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get login_welcome_back {
    return Intl.message(
      'Welcome Back',
      name: 'login_welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your details to sign in.`
  String get login_welcome_subtitle {
    return Intl.message(
      'Please enter your details to sign in.',
      name: 'login_welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get login_email {
    return Intl.message(
      'Email Address',
      name: 'login_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get login_email_hint {
    return Intl.message(
      'Enter your email',
      name: 'login_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_password {
    return Intl.message('Password', name: 'login_password', desc: '', args: []);
  }

  /// `Enter your password`
  String get login_password_hint {
    return Intl.message(
      'Enter your password',
      name: 'login_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get login_forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'login_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get login_sign_in {
    return Intl.message('Sign in', name: 'login_sign_in', desc: '', args: []);
  }

  /// `OR`
  String get login_or {
    return Intl.message('OR', name: 'login_or', desc: '', args: []);
  }

  /// `Sign in with Google`
  String get login_google_signin {
    return Intl.message(
      'Sign in with Google',
      name: 'login_google_signin',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get login_no_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'login_no_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get login_sign_up {
    return Intl.message('Sign up', name: 'login_sign_up', desc: '', args: []);
  }

  /// `Applications`
  String get applications {
    return Intl.message(
      'Applications',
      name: 'applications',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsScreenTitle {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rafeeq`
  String get platformName {
    return Intl.message('Rafeeq', name: 'platformName', desc: '', args: []);
  }

  /// `Please review the following terms and conditions carefully before using the platform.`
  String get termsScreenSubtitle {
    return Intl.message(
      'Please review the following terms and conditions carefully before using the platform.',
      name: 'termsScreenSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Introduction`
  String get termsIntroSectionTitle {
    return Intl.message(
      'Introduction',
      name: 'termsIntroSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rafeeq is a digital platform designed to connect founders with investors in a professional and secure environment. By accessing or using the platform, you agree to be bound by these Terms and Conditions.`
  String get termsIntroSectionContent {
    return Intl.message(
      'Rafeeq is a digital platform designed to connect founders with investors in a professional and secure environment. By accessing or using the platform, you agree to be bound by these Terms and Conditions.',
      name: 'termsIntroSectionContent',
      desc: '',
      args: [],
    );
  }

  /// `User Responsibilities`
  String get userResponsibilitiesTitle {
    return Intl.message(
      'User Responsibilities',
      name: 'userResponsibilitiesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Users are responsible for providing accurate, complete, and up-to-date information. Each user is fully responsible for the content, data, and materials shared through the platform.`
  String get userResponsibilitiesContent {
    return Intl.message(
      'Users are responsible for providing accurate, complete, and up-to-date information. Each user is fully responsible for the content, data, and materials shared through the platform.',
      name: 'userResponsibilitiesContent',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Data Protection`
  String get privacyAndDataTitle {
    return Intl.message(
      'Privacy & Data Protection',
      name: 'privacyAndDataTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rafeeq is committed to protecting user data and privacy. All personal and business information is handled in accordance with our Privacy Policy and will not be shared without proper authorization.`
  String get privacyAndDataContent {
    return Intl.message(
      'Rafeeq is committed to protecting user data and privacy. All personal and business information is handled in accordance with our Privacy Policy and will not be shared without proper authorization.',
      name: 'privacyAndDataContent',
      desc: '',
      args: [],
    );
  }

  /// `Projects & Investments`
  String get projectsAndInvestmentsTitle {
    return Intl.message(
      'Projects & Investments',
      name: 'projectsAndInvestmentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `The platform allows founders to present projects and investment opportunities. All information provided is for informational purposes only and does not constitute financial, legal, or investment advice.`
  String get projectsAndInvestmentsContent {
    return Intl.message(
      'The platform allows founders to present projects and investment opportunities. All information provided is for informational purposes only and does not constitute financial, legal, or investment advice.',
      name: 'projectsAndInvestmentsContent',
      desc: '',
      args: [],
    );
  }

  /// `Information Accuracy`
  String get informationAccuracyTitle {
    return Intl.message(
      'Information Accuracy',
      name: 'informationAccuracyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Founders are solely responsible for the accuracy and validity of all financial, technical, and business information related to their projects. Rafeeq does not guarantee the completeness or reliability of any information presented.`
  String get informationAccuracyContent {
    return Intl.message(
      'Founders are solely responsible for the accuracy and validity of all financial, technical, and business information related to their projects. Rafeeq does not guarantee the completeness or reliability of any information presented.',
      name: 'informationAccuracyContent',
      desc: '',
      args: [],
    );
  }

  /// `Limitation of Liability`
  String get liabilityLimitationTitle {
    return Intl.message(
      'Limitation of Liability',
      name: 'liabilityLimitationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rafeeq shall not be held liable for any direct or indirect losses, damages, or claims arising from the use of the platform or reliance on any information provided by users.`
  String get liabilityLimitationContent {
    return Intl.message(
      'Rafeeq shall not be held liable for any direct or indirect losses, damages, or claims arising from the use of the platform or reliance on any information provided by users.',
      name: 'liabilityLimitationContent',
      desc: '',
      args: [],
    );
  }

  /// `Intellectual Property Rights`
  String get intellectualPropertyTitle {
    return Intl.message(
      'Intellectual Property Rights',
      name: 'intellectualPropertyTitle',
      desc: '',
      args: [],
    );
  }

  /// `All intellectual property rights related to the platform, including but not limited to content, design, trademarks, and software, are owned by Rafeeq and may not be used without prior written permission.`
  String get intellectualPropertyContent {
    return Intl.message(
      'All intellectual property rights related to the platform, including but not limited to content, design, trademarks, and software, are owned by Rafeeq and may not be used without prior written permission.',
      name: 'intellectualPropertyContent',
      desc: '',
      args: [],
    );
  }

  /// `Account Suspension or Termination`
  String get accountTerminationTitle {
    return Intl.message(
      'Account Suspension or Termination',
      name: 'accountTerminationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rafeeq reserves the right to suspend or terminate any user account at its sole discretion in the event of a violation of these Terms or misuse of the platform.`
  String get accountTerminationContent {
    return Intl.message(
      'Rafeeq reserves the right to suspend or terminate any user account at its sole discretion in the event of a violation of these Terms or misuse of the platform.',
      name: 'accountTerminationContent',
      desc: '',
      args: [],
    );
  }

  /// `Updates to Terms`
  String get termsUpdatesTitle {
    return Intl.message(
      'Updates to Terms',
      name: 'termsUpdatesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rafeeq reserves the right to modify or update these Terms and Conditions at any time. Continued use of the platform constitutes acceptance of any such changes.`
  String get termsUpdatesContent {
    return Intl.message(
      'Rafeeq reserves the right to modify or update these Terms and Conditions at any time. Continued use of the platform constitutes acceptance of any such changes.',
      name: 'termsUpdatesContent',
      desc: '',
      args: [],
    );
  }

  /// `Contact & Support`
  String get supportAndContactTitle {
    return Intl.message(
      'Contact & Support',
      name: 'supportAndContactTitle',
      desc: '',
      args: [],
    );
  }

  /// `For any inquiries, support requests, or concerns regarding these Terms, users may contact the Rafeeq support team through the official communication channels within the application.`
  String get supportAndContactContent {
    return Intl.message(
      'For any inquiries, support requests, or concerns regarding these Terms, users may contact the Rafeeq support team through the official communication channels within the application.',
      name: 'supportAndContactContent',
      desc: '',
      args: [],
    );
  }

  /// `Last updated: February 2025`
  String get termsLastUpdateLabel {
    return Intl.message(
      'Last updated: February 2025',
      name: 'termsLastUpdateLabel',
      desc: '',
      args: [],
    );
  }

  /// `By using Rafeeq, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.`
  String get termsAcceptanceNote {
    return Intl.message(
      'By using Rafeeq, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.',
      name: 'termsAcceptanceNote',
      desc: '',
      args: [],
    );
  }

  /// `App Theme`
  String get theme {
    return Intl.message('App Theme', name: 'theme', desc: '', args: []);
  }

  /// `FAQ & Chat centre`
  String get FAQChatcentre {
    return Intl.message(
      'FAQ & Chat centre',
      name: 'FAQChatcentre',
      desc: '',
      args: [],
    );
  }

  /// `Give the rating`
  String get givetheRating {
    return Intl.message(
      'Give the rating',
      name: 'givetheRating',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Condition`
  String get termsAndCondition {
    return Intl.message(
      'Terms & Condition',
      name: 'termsAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `About Rafeeq team`
  String get aboutRafeeqteam {
    return Intl.message(
      'About Rafeeq team',
      name: 'aboutRafeeqteam',
      desc: '',
      args: [],
    );
  }

  /// `Exit the app`
  String get exittheapp {
    return Intl.message('Exit the app', name: 'exittheapp', desc: '', args: []);
  }

  /// `Choose App Theme`
  String get theme_title {
    return Intl.message(
      'Choose App Theme',
      name: 'theme_title',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get theme_light_title {
    return Intl.message(
      'Light Theme',
      name: 'theme_light_title',
      desc: '',
      args: [],
    );
  }

  /// `Clean and bright interface`
  String get theme_light_subtitle {
    return Intl.message(
      'Clean and bright interface',
      name: 'theme_light_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get theme_dark_title {
    return Intl.message(
      'Dark Theme',
      name: 'theme_dark_title',
      desc: '',
      args: [],
    );
  }

  /// `Easy on the eyes in low light`
  String get theme_dark_subtitle {
    return Intl.message(
      'Easy on the eyes in low light',
      name: 'theme_dark_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `System Theme`
  String get theme_system_title {
    return Intl.message(
      'System Theme',
      name: 'theme_system_title',
      desc: '',
      args: [],
    );
  }

  /// `Matches your device settings`
  String get theme_system_subtitle {
    return Intl.message(
      'Matches your device settings',
      name: 'theme_system_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `About Rafeeq Team`
  String get about_team_title {
    return Intl.message(
      'About Rafeeq Team',
      name: 'about_team_title',
      desc: '',
      args: [],
    );
  }

  /// `Meet the team behind the design and development of this application.`
  String get about_team_description {
    return Intl.message(
      'Meet the team behind the design and development of this application.',
      name: 'about_team_description',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
