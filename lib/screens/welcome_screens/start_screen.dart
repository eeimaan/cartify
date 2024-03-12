import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/screens/screens.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.startPageImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: size.height * 0.26),
                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(right: 15),
                //       child: Image.asset(
                //         AppImage.appLogoOnPage,
                //         width: size.width * 0.3,
                //         height: size.width * 0.3,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: size.height * 0.85),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                  child: CustomButton(
                    width: size.width,
                    height: size.height * 0.06,
                    buttonText: AppText.getStartedButtonText,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.createAccount);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                      ),
                      children: [
                        const TextSpan(
                          text: AppText.alreadyHaveAccountText,
                          style: TextStyle(
                            color: AppColors.colorBlack,
                          ),
                        ),
                        TextSpan(
                          text: AppText.loginText,
                          style: const TextStyle(
                            color: AppColors.colorDarkBkue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, AppRoutes.loginScreen);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
