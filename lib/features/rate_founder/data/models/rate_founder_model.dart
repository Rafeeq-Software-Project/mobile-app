class RateFounderModel {
  final String founderName;
  final String role;
  final String imageUrl;
  final String collaborationDate;
  final int rating;
  final String experienceTag;
  final String communicationTag;
  final String professionalismTag;
  final String updatesTag;
  final String review;

  RateFounderModel({
    required this.founderName,
    required this.role,
    required this.imageUrl,
    required this.collaborationDate,
    this.rating = 0,
    this.experienceTag = '',
    this.communicationTag = '',
    this.professionalismTag = '',
    this.updatesTag = '',
    this.review = '',
  });

  static RateFounderModel sample() {
    return RateFounderModel(
      founderName: 'Alex Johnson',
      role: 'CEO of TechNexus',
      imageUrl: 'https://i.pravatar.cc/300?img=33',
      collaborationDate: 'Collaboration: Q3 2023',
    );
  }
}
