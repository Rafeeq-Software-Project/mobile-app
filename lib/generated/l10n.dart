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

  /// `Road Map`
  String get roadMap {
    return Intl.message('Road Map', name: 'roadMap', desc: '', args: []);
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
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
