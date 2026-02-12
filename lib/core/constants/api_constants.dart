class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = 'http://rafeeq-api.runasp.net/api';

  // Auth Endpoints
  static const String register = '/Auth/register';
  static const String login = '/Auth/login';
  static const String sendEmailConfirmation = '/Auth/send-email-confirmation';
  static const String confirmEmail = '/Auth/confirm-email';
  static const String forgetPassword = '/Auth/forget-password';
  static const String resetPassword = '/Auth/reset-password';
  static const String registerCharity = '/Charity/register';
  static const String registerRestaurant = '/Restaurant/register';
}
