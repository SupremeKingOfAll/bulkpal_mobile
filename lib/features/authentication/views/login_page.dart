import 'package:bulkpal_mobile/core/utils/app_colours.dart';
import 'package:bulkpal_mobile/core/widgets/custom_text.dart';
import 'package:bulkpal_mobile/features/authentication/views/register_view.dart';
import 'package:bulkpal_mobile/features/authentication/view_models/login_view_model.dart';
import 'package:bulkpal_mobile/features/authentication/view_models/register_view_model.dart';
import 'package:bulkpal_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  bool IsPasswordHidden = true;

  Future<void> signIn() async {
    FocusScope.of(context).unfocus();

    final vm = context.read<LoginViewModel>();

    await vm.signIn(
      email: EmailController.text,
      password: PasswordController.text,
    );
  }

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
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

  Widget BuildSocialButton({required IconData IconValue}) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2233),
        shape: BoxShape.circle,
        border: Border.all(color: AppColours.borderColour),
      ),
      child: Icon(IconValue, color: AppColours.textColour, size: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

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
                    const SizedBox(height: 36),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 28, 22, 26),
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
                              'Welcome Back',
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
                              'Track your surplus. Build consistency.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColours.textSecondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 34),
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
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BuildSectionLabel('Password'),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Forgot password not added yet',
                                      ),
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: AppColours.accentColour,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                          if (vm.errorMessage.isNotEmpty) ...[
                            const SizedBox(height: 16),
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
                          const SizedBox(height: 26),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: ElevatedButton(
                              onPressed: vm.isLoading ? null : signIn,
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
                                      'Log In',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Row(
                            children: const [
                              Expanded(
                                child: Divider(
                                  color: AppColours.borderColour,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'OR CONTINUE WITH',
                                  style: TextStyle(
                                    color: AppColours.textSecondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColours.borderColour,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BuildSocialButton(
                                IconValue: Icons.android_rounded,
                              ),
                              const SizedBox(width: 18),
                              BuildSocialButton(IconValue: Icons.apple_rounded),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text(
                          'Don’t have an account? ',
                          style: TextStyle(
                            color: AppColours.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) => RegisterViewModel(
                                    authService: AuthService(),
                                  ),
                                  child: const RegisterView(),
                                ),
                              ),
                            );
                          },
                          child: CustomText(
                            customText: 'Register',
                            myColour: AppColours.accentColour,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 34),
                    const Text(
                      'PRECISION NUTRITION ARCHITECTURE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
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
