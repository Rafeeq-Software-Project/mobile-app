class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = 'http://rafeeq-api.runasp.net/api';

  // Auth Endpoints
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String resetPassword = '/auth/reset-password';
  static const String refreshToken = '/auth/refresh-token';
  static const String founderProfile = '/founders/me';
  static const String investorProfile = '/investors/me';
  static const String uploadInvestorProfile = '/investors/me/profile-picture';
  static const String updateInvestorProfile = '/investors/me';
  static const String updateFounderProfile = '/founders/me';
  static const String getAllProjects = '/founder/projects';
  static const String getProjectDetails = '/founder/projects/{id}';
  static const String createProject = '/founder/projects';
  static const String updateProject = '/founder/projects/{project_id}';
  static const String deleteProject = '/founder/projects/{project_id}';
  static const String getAllPendingDrafts = '/founder/projects/drafts/pending';
  static const String getDetailsDrafts =
      '/founder/projects/{{project_id}}/draft';
}
