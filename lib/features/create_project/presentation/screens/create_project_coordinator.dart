import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/create_project/data/models/project_data_model.dart';
import 'package:rafeeq_app/features/create_project/presentation/logic/create_project/create_project_cubit.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step1_basics_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step2_details_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step3_fundin_details_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step4_review_screen.dart';
import 'package:rafeeq_app/features/create_project/presentation/screens/step5_success_screen.dart';

class CreateProjectCoordinator extends StatelessWidget {
  const CreateProjectCoordinator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateProjectCubit>(),
      child: const _CreateProjectCoordinatorView(),
    );
  }
}

class _CreateProjectCoordinatorView extends StatefulWidget {
  const _CreateProjectCoordinatorView();

  @override
  State<_CreateProjectCoordinatorView> createState() =>
      _CreateProjectCoordinatorViewState();
}

class _CreateProjectCoordinatorViewState
    extends State<_CreateProjectCoordinatorView> {
  final PageController _pageController = PageController();
  final ProjectDataModel _projectData = ProjectDataModel();
  int _currentStep = 0;

  void _goToNextStep() {
    if (_currentStep < 4) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
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
        // Step 1: name + category
        Step1BasicsScreen(projectData: _projectData, onNext: _goToNextStep),

        // Step 2: description + useOfFunds
        Step2DetailsScreen(
          projectData: _projectData,
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        ),

        // Step 3: fundingGoal + startDate + endDate
        Step3FundingScreen(
          projectData: _projectData,
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        ),

        // Step 4: review → createProject via Cubit → onNext goes to success
        Step4ReviewScreen(
          projectData: _projectData,
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        ),

        // Step 5: success screen (reached after cubit emits success)
        Step5SuccessScreen(projectData: _projectData),
      ],
    );
  }
}
