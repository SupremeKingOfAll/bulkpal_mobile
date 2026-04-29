import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/features/authentication/views/login_page.dart';
import 'package:bulkpal_mobile/features/authentication/view_models/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController FullNameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController ConfirmPasswordController =
      TextEditingController();

  bool IsPasswordHidden = true;
  bool IsConfirmPasswordHidden = true;
  bool HasAcceptedTerms = false;

  Future<void> register() async {
    FocusScope.of(context).unfocus();

    final vm = context.read<RegisterViewModel>();

    final success = await vm.register(
      fullName: FullNameController.text,
      email: EmailController.text,
      password: PasswordController.text,
      confirmPassword: ConfirmPasswordController.text,
      hasAcceptedTerms: HasAcceptedTerms,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    FullNameController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    ConfirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration BuildInputDecoration({
    required String HintText,
    required IconData PrefixIcon,
    Widget? SuffixIcon,
  }) {
    return InputDecoration(
      hintText: HintText,
      hintStyle: const TextStyle(color: AppColours.textSecondary, fontSize: 14),
      prefixIcon: Icon(PrefixIcon, color: AppColours.textSecondary, size: 20),
      suffixIcon: SuffixIcon,
      filled: true,
      fillColor: const Color(0xFF111827),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColours.borderColour, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColours.accentColour,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColours.errorColour, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: AppColours.errorColour, width: 1.2),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
    );
  }

  Widget BuildSectionLabel(String TextValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          TextValue.toUpperCase(),
          style: const TextStyle(
            color: AppColours.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RegisterViewModel>();

    return Scaffold(
      backgroundColor: AppColours.primaryColour,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF050816), Color(0xFF02040A)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.insights_rounded,
                          color: AppColours.accentColour,
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'BulkPal',
                          style: TextStyle(
                            color: AppColours.accentColour,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 34),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
                      decoration: BoxDecoration(
                        color: AppColours.cardColour.withOpacity(0.96),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColours.borderColour,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColours.secondaryAccent.withOpacity(0.10),
                            blurRadius: 35,
                            spreadRadius: 1,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                color: AppColours.textColour,
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              'Join BulkPal and start your journey.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColours.textSecondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          BuildSectionLabel('Full Name'),
                          TextField(
                            controller: FullNameController,
                            style: const TextStyle(
                              color: AppColours.textColour,
                              fontSize: 15,
                            ),
                            decoration: BuildInputDecoration(
                              HintText: 'Bob Marley',
                              PrefixIcon: Icons.person_outline,
                            ),
                          ),
                          const SizedBox(height: 20),
                          BuildSectionLabel('Email Address'),
                          TextField(
                            controller: EmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: AppColours.textColour,
                              fontSize: 15,
                            ),
                            decoration: BuildInputDecoration(
                              HintText: 'name@example.com',
                              PrefixIcon: Icons.email_outlined,
                            ),
                          ),
                          const SizedBox(height: 20),
                          BuildSectionLabel('Password'),
                          TextField(
                            controller: PasswordController,
                            obscureText: IsPasswordHidden,
                            style: const TextStyle(
                              color: AppColours.textColour,
                              fontSize: 15,
                            ),
                            decoration: BuildInputDecoration(
                              HintText: '••••••••',
                              PrefixIcon: Icons.lock_outline,
                              SuffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    IsPasswordHidden = !IsPasswordHidden;
                                  });
                                },
                                icon: Icon(
                                  IsPasswordHidden
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColours.textSecondary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          BuildSectionLabel('Confirm Password'),
                          TextField(
                            controller: ConfirmPasswordController,
                            obscureText: IsConfirmPasswordHidden,
                            style: const TextStyle(
                              color: AppColours.textColour,
                              fontSize: 15,
                            ),
                            decoration: BuildInputDecoration(
                              HintText: '••••••••',
                              PrefixIcon: Icons.lock_outline,
                              SuffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    IsConfirmPasswordHidden =
                                        !IsConfirmPasswordHidden;
                                  });
                                },
                                icon: Icon(
                                  IsConfirmPasswordHidden
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColours.textSecondary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 0.95,
                                child: Checkbox(
                                  value: HasAcceptedTerms,
                                  onChanged: (Value) {
                                    setState(() {
                                      HasAcceptedTerms = Value ?? false;
                                    });
                                  },
                                  side: const BorderSide(
                                    color: AppColours.textSecondary,
                                    width: 1.2,
                                  ),
                                  activeColor: AppColours.accentColour,
                                  checkColor: AppColours.primaryColour,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        color: AppColours.textSecondary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        TextSpan(text: 'I agree to the '),
                                        TextSpan(
                                          text: 'Terms',
                                          style: TextStyle(
                                            color: AppColours.accentColour,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: AppColours.accentColour,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (vm.errorMessage.isNotEmpty) ...[
                            const SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColours.errorColour.withOpacity(0.10),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColours.errorColour.withOpacity(
                                    0.40,
                                  ),
                                ),
                              ),
                              child: Text(
                                vm.errorMessage,
                                style: const TextStyle(
                                  color: AppColours.errorColour,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              onPressed: vm.isLoading ? null : register,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColours.accentColour,
                                foregroundColor: AppColours.primaryColour,
                                disabledBackgroundColor: AppColours.accentColour
                                    .withOpacity(0.6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: vm.isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.4,
                                        color: AppColours.primaryColour,
                                      ),
                                    )
                                  : const Text(
                                      'Create Account',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    color: AppColours.textSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Log In',
                                    style: TextStyle(
                                      color: AppColours.accentColour,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
