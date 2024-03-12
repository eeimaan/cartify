import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/auth_services.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/email_validator.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/utils/theme.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // emailController.text = "Emaan@gmail.com";
    // passwordController.text = "123456";
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
   
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const LabelText(
          weight: FontWeight.w600,
          size: AppFonts.extraLarge,
          letterSpacing: 0.50,
          title: 'Welcome',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.2),
                    const LabelText(
                      weight: FontWeight.w500,
                      size: AppFonts.extraLarge,
                      letterSpacing: 0.50,
                      title: 'Lets create account',
                    ),
                    LabelText(
                      weight: FontWeight.w400,
                      size: AppFonts.small,
                      color: ThemeColors.textColorGrey(context),
                      letterSpacing: 0.50,
                      title: 'Just enter few quick things to get started',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFieldWidget(
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter your email';
                    } else if (!input.isValidEmail()) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  hintText: AppText.emailText,
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(height: size.height * 0.001),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: TextFieldWidget(
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    hintText: AppText.passwordText,
                    isDarkMode: isDarkMode,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.3),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomButton(
                  width: size.width,
                  height: size.height * 0.06,
                  buttonText: AppText.createAccountButtonText,
                  onPressed: () async {
                    // FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      try {
                        await AuthServices.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.pushNamed(context, AppRoutes.ecommercePage);
                        });
                      } on FirebaseAuthException catch (e) {
                        SchedulerBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.colorDarkBkue,
                                content: Text(
                                  ErrorMessages.getFirebaseErrorMessage(e.code),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(),
                          children: [
                            TextSpan(
                              text: AppText.createAccountAgreementText,
                              style: TextStyle(
                                fontSize: AppFonts.small,
                                color: ThemeColors.textColorGrey(context),
                              ),
                            ),
                            const TextSpan(
                              text: AppText.termsOfUse,
                              style: TextStyle(
                                color: AppColors.colorDarkBkue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(
                              text: AppText.and,
                              style: TextStyle(
                                color: AppColors.colorDarkBkue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(
                              text: AppText.privacyPolicy,
                              style: TextStyle(
                                color: AppColors.colorDarkBkue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
