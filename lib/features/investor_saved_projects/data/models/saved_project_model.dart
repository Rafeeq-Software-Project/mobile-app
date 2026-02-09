class SavedProjectModel {
  final String id;
  final String name;
  final String category;
  final String stage;
  final String imageUrl;
  final double raisedAmount;
  final double targetAmount;
  final int fundingProgress;
  bool isSaved;

  SavedProjectModel({
    required this.id,
    required this.name,
    required this.category,
    required this.stage,
    required this.imageUrl,
    required this.raisedAmount,
    required this.targetAmount,
    required this.fundingProgress,
    this.isSaved = true,
  });

  static List<SavedProjectModel> getSampleProjects() {
    return [
      SavedProjectModel(
        id: '1',
        name: 'EcoStream',
        category: 'CLEAN TECH',
        stage: 'SEED ROUND',
        imageUrl: 'eco',
        raisedAmount: 225,
        targetAmount: 0,
        fundingProgress: 50,
      ),
      SavedProjectModel(
        id: '2',
        name: 'MediConnect',
        category: 'HEALTHTECH',
        stage: 'SERIES A',
        imageUrl: 'medical',
        raisedAmount: 1.2,
        targetAmount: 5,
        fundingProgress: 80,
      ),
      SavedProjectModel(
        id: '3',
        name: 'AgroTech',
        category: 'FOOD & AGRI',
        stage: 'PRE-SEED',
        imageUrl: 'agro',
        raisedAmount: 550,
        targetAmount: 0,
        fundingProgress: 65,
      ),
      SavedProjectModel(
        id: '4',
        name: 'SkyHigh Robotics',
        category: 'ROBOTICS',
        stage: 'SERIES B',
        imageUrl: 'robotics',
        raisedAmount: 3.2,
        targetAmount: 0,
        fundingProgress: 84,
      ),
      SavedProjectModel(
        id: '5',
        name: 'GreenLeaf Pack',
        category: 'RETAIL',
        stage: 'SEED ROUND',
        imageUrl: 'retail',
        raisedAmount: 1.2,
        targetAmount: 5,
        fundingProgress: 25,
      ),
    ];
  }
}
