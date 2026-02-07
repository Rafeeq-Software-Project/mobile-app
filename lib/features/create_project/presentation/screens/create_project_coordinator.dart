import 'package:flutter/material.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step1_basics_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step2_narrative_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step3_funding_details_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step4_review_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step5_success_screen.dart';

class CreateProjectCoordinator extends StatefulWidget {
  const CreateProjectCoordinator({super.key});

  @override
  State<CreateProjectCoordinator> createState() =>
      _CreateProjectCoordinatorState();
}

class _CreateProjectCoordinatorState extends State<CreateProjectCoordinator> {
  final PageController _pageController = PageController();
  final ProjectDataModel _projectData = ProjectDataModel();
  int _currentStep = 0;

  void _goToNextStep() {
    if (_currentStep < 4) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Step1BasicsScreen(projectData: _projectData, onNext: _goToNextStep),
        Step2NarrativeScreen(
          projectData: _projectData,
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        ),
        Step3FundingDetailsScreen(
          projectData: _projectData,
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        ),
        Step4ReviewScreen(
          projectData: _projectData,
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        ),
        Step5SuccessScreen(projectData: _projectData),
      ],
    );
  }
}
