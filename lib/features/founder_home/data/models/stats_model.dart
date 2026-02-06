class StatsModel {
  final String label;
  final String value;
  final String changePercentage;
  final bool isPositive;
  final bool isHighlighted;

  StatsModel({
    required this.label,
    required this.value,
    required this.changePercentage,
    this.isPositive = true,
    this.isHighlighted = false,
  });
}
