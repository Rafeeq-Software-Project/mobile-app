class UserProfileModel {
  final String name;
  final String location;
  final bool isVerified;
  final String profileImageUrl;
  final int followers;
  final int projectsCount;
  final int successRate;
  final String aboutMe;
  final List<String> skills;
  final VentureModel? currentVenture;
  final List<PortfolioProject> portfolio;
  final ReputationModel reputation;

  UserProfileModel({
    required this.name,
    required this.location,
    required this.isVerified,
    required this.profileImageUrl,
    required this.followers,
    required this.projectsCount,
    required this.successRate,
    required this.aboutMe,
    required this.skills,
    this.currentVenture,
    required this.portfolio,
    required this.reputation,
  });

  // Sample data
  static UserProfileModel sample() {
    return UserProfileModel(
      name: 'Sarah Jenning',
      location: 'Founder & CEO @ GreenTech',
      isVerified: true,
      profileImageUrl: 'https://i.pravatar.cc/300?img=47',
      followers: 41,
      projectsCount: 12,
      successRate: 98,
      aboutMe:
          'Passionate about sustainable energy solutions and building technology that matters. With over 8 years of experience in cleantech, I\'m currently developing solutions that reduce energy consumption for modern households and promote application.',
      skills: ['AI/ML', '#SocialImpact'],
      currentVenture: VentureModel(
        name: 'SolarFlare',
        status: 'RECRUITING',
        description: 'Solar-powered IoT ecosystem for modern households',
        iconUrl: 'solar',
      ),
      portfolio: [
        PortfolioProject(
          name: 'FinDash Analytics',
          description: 'AI-Powered dashboard tool',
          imageUrl: 'analytics',
          tag: 'Exited',
        ),
        PortfolioProject(
          name: 'EcoTrack',
          description: 'Carbon footprint tracker',
          imageUrl: 'eco',
          tag: 'Completed',
        ),
      ],
      reputation: ReputationModel(
        overallRating: 4.9,
        totalReviews: 124,
        ratings: {5: 85, 4: 10, 3: 3, 2: 1, 1: 1},
      ),
    );
  }
}

class VentureModel {
  final String name;
  final String status;
  final String description;
  final String iconUrl;

  VentureModel({
    required this.name,
    required this.status,
    required this.description,
    required this.iconUrl,
  });
}

class PortfolioProject {
  final String name;
  final String description;
  final String imageUrl;
  final String tag;

  PortfolioProject({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.tag,
  });
}

class ReputationModel {
  final double overallRating;
  final int totalReviews;
  final Map<int, int> ratings;

  ReputationModel({
    required this.overallRating,
    required this.totalReviews,
    required this.ratings,
  });

  int getRatingPercentage(int stars) {
    final count = ratings[stars] ?? 0;
    if (totalReviews == 0) return 0;
    return ((count / totalReviews) * 100).round();
  }
}
