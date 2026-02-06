class DashboardProjectModel {
  final String title;
  final int volunteers;
  final String dueDate;
  final String status;
  final String statusColor;
  final double progress;

  DashboardProjectModel({
    required this.title,
    required this.volunteers,
    required this.dueDate,
    required this.status,
    required this.statusColor,
    required this.progress,
  });
}
