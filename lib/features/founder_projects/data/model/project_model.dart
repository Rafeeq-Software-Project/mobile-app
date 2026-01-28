class ProjectModel {
  final String title;
  final String description;
  final String status;
  final String category;
  final double raisedAmount;
  final double goalAmount;
  final String statusLabel;
  final String statusColor;
  final String imageUrl;
  final bool isDraft;

  ProjectModel({
    required this.title,
    required this.description,
    required this.status,
    required this.category,
    required this.raisedAmount,
    required this.goalAmount,
    required this.statusLabel,
    required this.statusColor,
    required this.imageUrl,
    this.isDraft = false,
  });

  double get fundingPercentage {
    if (goalAmount == 0) return 0;
    return (raisedAmount / goalAmount) * 100;
  }
}
