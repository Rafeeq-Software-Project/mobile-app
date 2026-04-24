import 'package:animate_do/animate_do.dart';
import 'package:rafeeq_app/core/utils/common_imports.dart';
import 'package:rafeeq_app/features/create_project/data/models/create_project_request.dart';
import 'package:rafeeq_app/features/create_project/presentation/logic/update_project/update_project_cubit.dart';
import 'package:rafeeq_app/features/create_project/presentation/logic/update_project/update_project_state.dart';
import 'package:rafeeq_app/features/founder_projects/data/model/project_model.dart';
import '../widgets/background_decoration.dart';

class UpdateProjectScreen extends StatelessWidget {
  final ProjectModel project;

  const UpdateProjectScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<UpdateProjectCubit>(),
      child: _UpdateProjectView(project: project),
    );
  }
}

class _UpdateProjectView extends StatefulWidget {
  final ProjectModel project;

  const _UpdateProjectView({required this.project});

  @override
  State<_UpdateProjectView> createState() => _UpdateProjectViewState();
}

class _UpdateProjectViewState extends State<_UpdateProjectView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _fundingGoalController;
  late final TextEditingController _useOfFundsController;
  late DateTime _startDate;
  late DateTime _endDate;
  String? _selectedCategory;

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Technology', 'icon': Icons.computer_rounded},
    {'label': 'Healthcare', 'icon': Icons.medical_services_rounded},
    {'label': 'Education', 'icon': Icons.school_rounded},
    {'label': 'Agriculture', 'icon': Icons.eco_rounded},
    {'label': 'Finance', 'icon': Icons.account_balance_rounded},
    {'label': 'Other', 'icon': Icons.category_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project.name);
    _descriptionController = TextEditingController(
      text: widget.project.description,
    );
    _selectedCategory = widget.project.category.isEmpty
        ? null
        : widget.project.category;
    _fundingGoalController = TextEditingController(
      text: widget.project.fundingGoal.toString(),
    );
    _useOfFundsController = TextEditingController(
      text: widget.project.useOfFunds,
    );
    _startDate = widget.project.startDate;
    _endDate = widget.project.endDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _fundingGoalController.dispose();
    _useOfFundsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a category'),
          backgroundColor: context.customAppColors.error500,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    final request = CreateProjectRequest(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory ?? '',
      fundingGoal: double.parse(_fundingGoalController.text.trim()),
      useOfFunds: _useOfFundsController.text.trim(),
      startDate: _startDate.toIso8601String(),
      endDate: _endDate.toIso8601String(),
    );

    context.read<UpdateProjectCubit>().updateProject(
      widget.project.id,
      request,
    );
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart ? _startDate : _endDate;
    final first = isStart ? DateTime(2000) : _startDate;
    final last = isStart ? _endDate : DateTime(2100);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: context.customAppColors.primary600,
            onPrimary: Colors.white,
            surface: context.customAppColors.grey0,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProjectCubit, UpdateProjectState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: (response) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => _UpdateSuccessDialog(
                mode: response.mode,
                message: response.message,
                onDone: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // go back to details
                },
              ),
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: context.customAppColors.error500,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: context.customAppColors.grey50,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: FadeInLeft(
            duration: const Duration(milliseconds: 400),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.customAppColors.grey0,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF4A90E2).withValues(alpha: .15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.customAppColors.primary600.withValues(
                      alpha: .12,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.customAppColors.primary900,
                  size: 18,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          title: FadeInDown(
            duration: const Duration(milliseconds: 400),
            child: Text(
              'Edit Project',
              style: TextStyle(
                color: context.customAppColors.primary900,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            BackgroundDecoration(),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: _SectionTitle(title: 'Basic Info'),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        delay: const Duration(milliseconds: 150),
                        child: _AppTextField(
                          controller: _nameController,
                          label: 'Project Name',
                          hint: 'Enter project name',
                          icon: Icons.folder_outlined,
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(height: 14),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: Text(
                          'Industry / Category',
                          style: TextStyle(
                            color: context.customAppColors.primary900,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2.4,
                            ),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          final cat = _categories[index];
                          final isSelected = _selectedCategory == cat['label'];
                          return FadeInUp(
                            duration: const Duration(milliseconds: 400),
                            delay: Duration(milliseconds: 200 + index * 50),
                            child: _CategoryChip(
                              label: cat['label'] as String,
                              icon: cat['icon'] as IconData,
                              isSelected: isSelected,
                              onTap: () => setState(
                                () =>
                                    _selectedCategory = cat['label'] as String,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                      FadeInUp(
                        delay: const Duration(milliseconds: 250),
                        child: _AppTextField(
                          controller: _descriptionController,
                          label: 'Description',
                          hint: 'Describe your project...',
                          icon: Icons.description_outlined,
                          maxLines: 4,
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: _SectionTitle(title: 'Funding'),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        delay: const Duration(milliseconds: 350),
                        child: _AppTextField(
                          controller: _fundingGoalController,
                          label: 'Funding Goal',
                          hint: '0.00',
                          icon: Icons.attach_money_rounded,
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Required';
                            }
                            if (double.tryParse(v.trim()) == null) {
                              return 'Enter a valid number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 14),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: _AppTextField(
                          controller: _useOfFundsController,
                          label: 'Use of Funds',
                          hint: 'How will the funds be used?',
                          icon: Icons.account_balance_wallet_outlined,
                          maxLines: 3,
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        delay: const Duration(milliseconds: 450),
                        child: _SectionTitle(title: 'Timeline'),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: Row(
                          children: [
                            Expanded(
                              child: _DatePickerTile(
                                label: 'Start Date',
                                date: _startDate,
                                icon: Icons.calendar_today_outlined,
                                onTap: () => _pickDate(isStart: true),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _DatePickerTile(
                                label: 'End Date',
                                date: _endDate,
                                icon: Icons.event_outlined,
                                onTap: () => _pickDate(isStart: false),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      FadeInUp(
                        delay: const Duration(milliseconds: 550),
                        child:
                            BlocBuilder<UpdateProjectCubit, UpdateProjectState>(
                              builder: (context, state) {
                                final isLoading = state.maybeWhen(
                                  loading: () => true,
                                  orElse: () => false,
                                );
                                return SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: ElevatedButton(
                                    onPressed: isLoading ? null : _submit,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          context.customAppColors.primary600,
                                      disabledBackgroundColor: context
                                          .customAppColors
                                          .primary600
                                          .withValues(alpha: .6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation: 4,
                                      shadowColor: context
                                          .customAppColors
                                          .primary600
                                          .withValues(alpha: .35),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : const Text(
                                            'Save Changes',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Reusable Widgets ────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: context.customAppColors.primary900,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _AppTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(color: context.customAppColors.primary900, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: context.customAppColors.primary600,
          size: 20,
        ),
        labelStyle: TextStyle(
          color: context.customAppColors.grey600,
          fontSize: 13,
        ),
        hintStyle: TextStyle(
          color: context.customAppColors.grey400,
          fontSize: 13,
        ),
        filled: true,
        fillColor: context.customAppColors.grey0,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: const Color(0xFF4A90E2).withValues(alpha: .2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: const Color(0xFF4A90E2).withValues(alpha: .15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: context.customAppColors.primary600,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.customAppColors.error500),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: context.customAppColors.error500,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class _DatePickerTile extends StatelessWidget {
  final String label;
  final DateTime date;
  final IconData icon;
  final VoidCallback onTap;

  const _DatePickerTile({
    required this.label,
    required this.date,
    required this.icon,
    required this.onTap,
  });

  String _format(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: context.customAppColors.grey0,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF4A90E2).withValues(alpha: .15),
          ),
          boxShadow: [
            BoxShadow(
              color: context.customAppColors.primary600.withValues(alpha: .06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: context.customAppColors.primary600, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: context.customAppColors.grey600,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _format(date),
                    style: TextStyle(
                      color: context.customAppColors.primary900,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: context.customAppColors.grey600,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Success Dialog ───────────────────────────────────────────────────────────

class _UpdateSuccessDialog extends StatelessWidget {
  final String mode;
  final String message;
  final VoidCallback onDone;

  const _UpdateSuccessDialog({
    required this.mode,
    required this.message,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final isDraft = mode.toLowerCase() == 'draft';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: context.customAppColors.grey0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: context.customAppColors.primary800.withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDraft
                    ? Icons.hourglass_top_rounded
                    : Icons.check_circle_outline_rounded,
                size: 32,
                color: context.customAppColors.primary800,
              ),
            ),
            const SizedBox(height: 16),

            // Mode badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isDraft
                    ? const Color(0xFFFFF3CD)
                    : context.customAppColors.primary800.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                mode,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: isDraft
                      ? const Color(0xFFB07D00)
                      : context.customAppColors.primary600,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              isDraft ? 'Submitted for Review' : 'Updated Successfully',
              style: TextStyle(
                color: context.customAppColors.primary800,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Message from API
            Text(
              message,
              style: TextStyle(
                color: context.customAppColors.neutral700,
                fontSize: 13,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Done button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDraft
                      ? context.customAppColors.primary800
                      : context.customAppColors.primary800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected
            ? colors.primary800.withValues(alpha: .08)
            : colors.grey50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? colors.primary800 : colors.grey200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary800.withValues(alpha: .15)
                      : colors.grey100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: isSelected ? colors.primary800 : colors.grey500,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? colors.primary800 : colors.grey700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  size: 16,
                  color: colors.primary800,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
