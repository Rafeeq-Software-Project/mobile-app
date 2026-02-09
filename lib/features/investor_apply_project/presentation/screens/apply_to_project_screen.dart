import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafeeq_app/core/theme/theme_manager/theme_extensions.dart';
import 'package:rafeeq_app/features/investor_apply_project/presentation/widgets/apply_widgets.dart';
import '../../data/models/application_model.dart';

class ApplyToProjectScreen extends StatefulWidget {
  const ApplyToProjectScreen({super.key});

  @override
  State<ApplyToProjectScreen> createState() => _ApplyToProjectScreenState();
}

class _ApplyToProjectScreenState extends State<ApplyToProjectScreen> {
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = true;
  final List<String> _attachments = [];

  late ProjectApplicationModel projectApplication;

  @override
  void initState() {
    super.initState();
    projectApplication = ProjectApplicationModel.sample();
    _messageController.text = projectApplication.message;
  }

  void _addAttachment() {
    setState(() {
      _attachments.add('document_${_attachments.length + 1}.pdf');
    });
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
    });
  }

  void _submitApplication() {
    if (_formKey.currentState!.validate() && _agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Application submitted successfully!'),
          backgroundColor: context.customAppColors.accent600,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      backgroundColor: colors.grey0,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            ApplyAppBar(onBackTap: () => Navigator.pop(context)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Header
                      ProjectApplyHeader(
                        projectName: projectApplication.projectName,
                        founderName: projectApplication.founderName,
                        imageUrl: projectApplication.imageUrl,
                      ),
                      SizedBox(height: 24.h),

                      // Message Section
                      MessageSection(controller: _messageController),
                      SizedBox(height: 24.h),

                      // Attachments Section
                      AttachmentsSection(
                        attachments: _attachments,
                        onAddAttachment: _addAttachment,
                        onRemoveAttachment: _removeAttachment,
                      ),
                      SizedBox(height: 24.h),

                      // Terms Agreement
                      TermsAgreement(
                        isAgreed: _agreedToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreedToTerms = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Submit Button
            SubmitButton(onTap: _submitApplication, isEnabled: _agreedToTerms),
          ],
        ),
      ),
    );
  }
}
