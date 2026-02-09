class MyProfileModel {
  final String name;
  final String title;
  final String location;
  final String imageUrl;
  final bool isVerified;
  final String bio;
  final int startupsReviewed;
  final int yearsActive;
  final double totalFunds;
  final List<String> focusAreas;
  final List<InvestmentModel> recentInvestments;

  MyProfileModel({
    required this.name,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.isVerified,
    required this.bio,
    required this.startupsReviewed,
    required this.yearsActive,
    required this.totalFunds,
    required this.focusAreas,
    required this.recentInvestments,
  });

  static MyProfileModel sample() {
    return MyProfileModel(
      name: 'Jassim Al-Fayed',
      title: 'Angel Investor',
      location: 'Riyadh, KSA',
      imageUrl: 'https://i.pravatar.cc/300?img=12',
      isVerified: true,
      bio:
          'Passionate about empowering early-stage startups in the MENA region. Focused on sustainable tech and AI innovation.',
      startupsReviewed: 12,
      yearsActive: 5,
      totalFunds: 2000000,
      focusAreas: [
        'FinTech',
        'Artificial Intelligence',
        'Sustainability',
        'E-commerce',
        'HealthTech',
        'EdTech',
      ],
      recentInvestments: [
        InvestmentModel(
          name: 'TechNova',
          date: 'Series A 2023',
          amount: 500,
          status: 'Active',
        ),
        InvestmentModel(
          name: 'GreenGrow',
          date: 'Seed Round 2022',
          amount: 250,
          status: 'Active',
        ),
        InvestmentModel(
          name: 'RoboFix',
          date: 'Pre-Seed • 2021',
          amount: 150,
          status: 'Exited',
        ),
      ],
    );
  }
}

class InvestmentModel {
  final String name;
  final String date;
  final double amount;
  final String status;

  InvestmentModel({
    required this.name,
    required this.date,
    required this.amount,
    required this.status,
  });
}
