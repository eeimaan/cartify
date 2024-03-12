import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/auth_services.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/email_validator.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    emailController.text = "eman@gmail.com";
    passwordController.text = "123456";
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
                      weight: FontWeight.w600,
                      size: AppFonts.extraLarge,
                      letterSpacing: 0.50,
                      title: 'login',
                    ),
                    SizedBox(height: size.height * 0.01),
                    LabelText(
                      weight: FontWeight.w400,
                      size: AppFonts.small,
                      color: ThemeColors.textColorGrey(context),
                      letterSpacing: 0.50,
                      title: 'Hello, Welcome back to Cartify',
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFieldWidget(
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'please enter your email';
                    } else if (!input.isValidEmail()) {
                      return 'please enter valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  hintText: AppText.emailText,
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(height: size.height * 0.001),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFieldWidget(
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'please enter your password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    hintText: AppText.passwordText,
                    isDarkMode: isDarkMode,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.15),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: CustomButton(
                  width: size.width,
                  height: size.height * 0.06,
                  buttonText: AppText.loginButtonText,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await AuthServices.logIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        SchedulerBinding.instance.addPostFrameCallback(
                          (timeStamp) {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.ecommercePage);
                          },
                        );
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
            ],
          ),
        ),
      ),
    );
  }
}
