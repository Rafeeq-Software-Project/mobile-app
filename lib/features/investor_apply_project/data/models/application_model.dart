class ApplicationModel {
  final String id;
  final String projectName;
  final String founderName;
  final String imageUrl;
  final String appliedDate;
  final String status;
  final double proposedAmount;

  ApplicationModel({
    required this.id,
    required this.projectName,
    required this.founderName,
    required this.imageUrl,
    required this.appliedDate,
    required this.status,
    required this.proposedAmount,
  });

  static List<ApplicationModel> getSampleApplications() {
    return [
      ApplicationModel(
        id: '1',
        projectName: 'Urban Greens Initiative',
        founderName: 'Applied: Oct 12, 2023',
        imageUrl: 'green',
        appliedDate: 'Oct 12, 2023',
        status: 'Approved',
        proposedAmount: 12000,
      ),
      ApplicationModel(
        id: '2',
        projectName: 'NextGen Logistics',
        founderName: 'Applied: Sept 18, 2023',
        imageUrl: 'logistics',
        appliedDate: 'Sept 18, 2023',
        status: 'Rejected',
        proposedAmount: 100000,
      ),
      ApplicationModel(
        id: '3',
        projectName: 'MediCure Labs',
        founderName: 'Applied: Dec 1, 2023',
        imageUrl: 'medical',
        appliedDate: 'Dec 1, 2023',
        status: 'Pending',
        proposedAmount: 75000,
      ),
    ];
  }
}

class ProjectApplicationModel {
  final String projectName;
  final String founderName;
  final String imageUrl;
  final String message;
  final List<String> attachments;

  ProjectApplicationModel({
    required this.projectName,
    required this.founderName,
    required this.imageUrl,
    required this.message,
    required this.attachments,
  });

  static ProjectApplicationModel sample() {
    return ProjectApplicationModel(
      projectName: 'GreenEnergy AI Initiative',
      founderName: 'by Sarah Smith',
      imageUrl: 'green_energy',
      message:
          'Hi Sarah, I\'m very interested in your vision for renewable AI...',
      attachments: [],
    );
  }
}
