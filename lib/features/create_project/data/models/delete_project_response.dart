class DeleteProjectResponse {
  final String message;

  DeleteProjectResponse({required this.message});

  factory DeleteProjectResponse.fromJson(Map<String, dynamic> json) {
    return DeleteProjectResponse(message: json['message']);
  }
}
