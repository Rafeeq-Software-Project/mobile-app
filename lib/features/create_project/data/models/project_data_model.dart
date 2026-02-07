class ProjectDataModel {
  // Step 1: Basics
  String projectName = '';
  String category = '';
  String currentStage = '';
  String? coverImagePath;

  // Step 2: Narrative
  String problemStatement = '';
  String solutionDescription = '';
  String targetMarket = '';
  List<String> tags = [];

  // Step 3: Funding
  double requiredFunding = 0;
  String currency = 'USD';
  String fundingType = '';

  // Additional metadata
  DateTime createdAt = DateTime.now();
  String status = 'draft';

  void reset() {
    projectName = '';
    category = '';
    currentStage = '';
    coverImagePath = null;
    problemStatement = '';
    solutionDescription = '';
    targetMarket = '';
    tags = [];
    requiredFunding = 0;
    currency = 'USD';
    fundingType = '';
    createdAt = DateTime.now();
    status = 'draft';
  }

  Map<String, dynamic> toJson() {
    return {
      'projectName': projectName,
      'category': category,
      'currentStage': currentStage,
      'coverImagePath': coverImagePath,
      'problemStatement': problemStatement,
      'solutionDescription': solutionDescription,
      'targetMarket': targetMarket,
      'tags': tags,
      'requiredFunding': requiredFunding,
      'currency': currency,
      'fundingType': fundingType,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}
