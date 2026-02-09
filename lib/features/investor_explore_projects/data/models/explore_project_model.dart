class ExploreProjectModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String stage;
  final double raisedAmount;
  final double targetAmount;
  final int fundingProgress;
  final List<String> tags;
  final bool isTrending;
  final bool isBookmarked;
  final List<FounderModel> founders;

  ExploreProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.stage,
    required this.raisedAmount,
    required this.targetAmount,
    required this.fundingProgress,
    required this.tags,
    this.isTrending = false,
    this.isBookmarked = false,
    required this.founders,
  });

  ExploreProjectModel copyWith({bool? isBookmarked}) {
    return ExploreProjectModel(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      category: category,
      stage: stage,
      raisedAmount: raisedAmount,
      targetAmount: targetAmount,
      fundingProgress: fundingProgress,
      tags: tags,
      isTrending: isTrending,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      founders: founders,
    );
  }

  static List<ExploreProjectModel> getSampleTrending() {
    return [
      ExploreProjectModel(
        id: '1',
        title: 'NovaPay Systems',
        description:
            'Revolutionizing cross-border payments for freelancers with blockchain technology.',
        imageUrl: 'meeting',
        category: 'FinTech',
        stage: 'SEED A',
        raisedAmount: 1.2,
        targetAmount: 5.0,
        fundingProgress: 80,
        tags: ['Raised', '\$1.2M of \$5M'],
        isTrending: true,
        founders: [
          FounderModel(
            name: 'John',
            imageUrl: 'https://i.pravatar.cc/150?img=12',
          ),
          FounderModel(
            name: 'Jane',
            imageUrl: 'https://i.pravatar.cc/150?img=47',
          ),
        ],
      ),
    ];
  }

  static List<ExploreProjectModel> getSampleOpportunities() {
    return [
      ExploreProjectModel(
        id: '2',
        title: 'BuildAI Solutions',
        description: 'Sustainable construction materials for modern eco homes.',
        imageUrl: 'building',
        category: 'PRE-SEED',
        stage: 'PRE-SEED',
        raisedAmount: 0.25,
        targetAmount: 0.0,
        fundingProgress: 25,
        tags: ['25% Equity', 'OpenNow'],
        founders: [],
      ),
      ExploreProjectModel(
        id: '3',
        title: 'MedTech AI',
        description:
            'AI-driven diagnostics for early detection of cardiac issues.',
        imageUrl: 'medical',
        category: 'SEED',
        stage: 'SEED',
        raisedAmount: 0.45,
        targetAmount: 0.0,
        fundingProgress: 0,
        tags: ['3m Equity', 'Health'],
        founders: [],
      ),
      ExploreProjectModel(
        id: '4',
        title: 'GreenGro Robotics',
        description: 'Automated harvesting systems for vertical farming.',
        imageUrl: 'agriculture',
        category: 'ANGEL',
        stage: 'ANGEL',
        raisedAmount: 0.11,
        targetAmount: 0.0,
        fundingProgress: 10,
        tags: ['10% Equity', 'AgTech'],
        founders: [],
      ),
    ];
  }
}

class FounderModel {
  final String name;
  final String imageUrl;

  FounderModel({required this.name, required this.imageUrl});
}

class ProjectDetailModel {
  final String id;
  final String title;
  final String tagline;
  final String imageUrl;
  final String category;
  final String stage;
  final String location;
  final double fundingAmount;
  final String fundingDuration;
  final String fundedStatus;
  final int teamSize;
  final String deadline;
  final String pitch;
  final FounderDetailModel founder;
  final List<DealHighlight> dealHighlights;
  final List<DocumentModel> documents;

  ProjectDetailModel({
    required this.id,
    required this.title,
    required this.tagline,
    required this.imageUrl,
    required this.category,
    required this.stage,
    required this.location,
    required this.fundingAmount,
    required this.fundingDuration,
    required this.fundedStatus,
    required this.teamSize,
    required this.deadline,
    required this.pitch,
    required this.founder,
    required this.dealHighlights,
    required this.documents,
  });

  static ProjectDetailModel sample() {
    return ProjectDetailModel(
      id: '1',
      title: 'EcoStream Analytics',
      tagline: 'AI-driven water management for smart cities',
      imageUrl: 'city',
      category: 'CleanTech',
      stage: 'Seed Round',
      location: 'Austin, TX',
      fundingAmount: 150000,
      fundingDuration: '6 mo',
      fundedStatus: '54% Funded',
      teamSize: 4,
      deadline: '30 Dec 24',
      pitch:
          'Water scarcity is an urgent challenge of the next decade. EcoStream uses AI to predict water usage, detect leaks in real-time, and optimize distribution. We partner with municipal systems across the US and are now scaling internationally. By connecting a vast IoT network of sensors with predictive models, we enable cities to save water, reduce waste, and prevent flooding—all through a single analytics platform.',
      founder: FounderDetailModel(
        name: 'Sarah Jenkins',
        title: 'Founder & CEO',
        imageUrl: 'https://i.pravatar.cc/300?img=47',
        isVerified: true,
      ),
      dealHighlights: [
        DealHighlight(icon: 'users', label: '\$6,000', sublabel: ''),
        DealHighlight(icon: 'chart', label: '\$44M Cap', sublabel: ''),
        DealHighlight(icon: 'equity', label: '10%', sublabel: ''),
        DealHighlight(icon: 'safe', label: 'SAFE', sublabel: ''),
      ],
      documents: [
        DocumentModel(
          title: 'Pitch Deck',
          subtitle: '14.2 mb',
          icon: 'pdf',
          color: 'red',
        ),
        DocumentModel(
          title: 'Financials',
          subtitle: '1.7 mb',
          icon: 'excel',
          color: 'green',
        ),
      ],
    );
  }
}

class FounderDetailModel {
  final String name;
  final String title;
  final String imageUrl;
  final bool isVerified;

  FounderDetailModel({
    required this.name,
    required this.title,
    required this.imageUrl,
    required this.isVerified,
  });
}

class DealHighlight {
  final String icon;
  final String label;
  final String sublabel;

  DealHighlight({
    required this.icon,
    required this.label,
    required this.sublabel,
  });
}

class DocumentModel {
  final String title;
  final String subtitle;
  final String icon;
  final String color;

  DocumentModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
