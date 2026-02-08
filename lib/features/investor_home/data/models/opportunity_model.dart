class OpportunityModel {
  final String id;
  final String title;
  final String company;
  final String industry;
  final String location;
  final String imageUrl;
  final String dueDate;
  final String equity;
  final String salary;
  final bool isBookmarked;
  final String? tag;
  final List<String> skills;
  final String description;

  OpportunityModel({
    required this.id,
    required this.title,
    required this.company,
    required this.industry,
    required this.location,
    required this.imageUrl,
    required this.dueDate,
    required this.equity,
    required this.salary,
    this.isBookmarked = false,
    this.tag,
    required this.skills,
    required this.description,
  });

  OpportunityModel copyWith({
    String? id,
    String? title,
    String? company,
    String? industry,
    String? location,
    String? imageUrl,
    String? dueDate,
    String? equity,
    String? salary,
    bool? isBookmarked,
    String? tag,
    List<String>? skills,
    String? description,
  }) {
    return OpportunityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      industry: industry ?? this.industry,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      dueDate: dueDate ?? this.dueDate,
      equity: equity ?? this.equity,
      salary: salary ?? this.salary,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      tag: tag ?? this.tag,
      skills: skills ?? this.skills,
      description: description ?? this.description,
    );
  }

  static List<OpportunityModel> getSampleData() {
    return [
      // Top Picks
      OpportunityModel(
        id: '1',
        title: 'GreenTech Solutions',
        company: 'GreenTech',
        industry: 'CleanTech',
        location: 'London',
        imageUrl: 'greentech',
        dueDate: 'Due: 8 Mar',
        equity: '12-3%',
        salary: '\$4M',
        tag: 'SEED A',
        skills: ['AI', 'SaaS'],
        description: 'Sustainable Energy solutions',
      ),
      OpportunityModel(
        id: '2',
        title: 'MediCare Plus',
        company: 'MediCare',
        industry: 'HealthTech',
        location: 'Cairo',
        imageUrl: 'medical',
        dueDate: 'Due: 12 Mar',
        equity: '8%',
        salary: '\$200k',
        tag: 'URGENT',
        skills: ['Health', 'Mobile'],
        description: 'Healthcare management platform',
      ),

      // Recent Opportunities
      OpportunityModel(
        id: '3',
        title: 'FinFlow',
        company: 'Fintech',
        industry: 'Pre-Seed',
        location: '',
        imageUrl: '',
        dueDate: '',
        equity: '10%',
        salary: '\$250k',
        skills: ['Finance', 'Blockchain'],
        description:
            'Automated cash flow management for small business using predictive analytics and secure...',
      ),
      OpportunityModel(
        id: '4',
        title: 'Edutainx',
        company: 'Edtech',
        industry: 'Seed',
        location: '',
        imageUrl: '',
        dueDate: '',
        equity: '15%',
        salary: '\$1.2M',
        skills: ['Education', 'AI'],
        description:
            'Personalized learning paths for high school students driven by AI/ML and gamific...',
      ),
      OpportunityModel(
        id: '5',
        title: 'LogiChain',
        company: 'Supply Chain',
        industry: 'Series A',
        location: '',
        imageUrl: '',
        dueDate: '',
        equity: '30%',
        salary: '\$5M',
        skills: ['Logistics', 'IoT'],
        description:
            'Blockchain-enabled supply chain transparency platform for international freight fo...',
      ),
    ];
  }
}
