import 'package:flutter/material.dart';
import 'package:dpm/screens/signin_screen.dart';
import 'package:dpm/screens/signup_screen.dart';
import 'package:dpm/theme/theme.dart';
import 'package:dpm/widgets/custom_scaffold.dart';
import 'package:dpm/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return CustomScaffold(
      child: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout(context, screenWidth, screenHeight);
          } else {
            return _buildLandscapeLayout(context, screenWidth, screenHeight);
          }
        },
      ),
    );
  }

  Widget _buildPortraitLayout(
      BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      children: [
        Flexible(
          flex: 8,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: screenWidth * 0.1, // 10% of screen width
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Domus power monitor\n',
                      style: TextStyle(
                        fontFamily: 'Matrice',
                        fontSize: screenWidth * 0.1, // Responsive font size
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '\nA energia da sua casa, sob o seu controle.',
                      style: TextStyle(
                        fontFamily: 'Matrice',
                        fontSize: screenWidth * 0.05, // Responsive font size
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                const Expanded(
                  child: WelcomeButton(
                    buttonText: 'Entrar',
                    onTap: SignInScreen(),
                    color: Colors.transparent,
                    textColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: WelcomeButton(
                    buttonText: 'Inscrever-se',
                    onTap: const SignUpScreen(),
                    color: Colors.white,
                    textColor: lightColorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(
      BuildContext context, double screenWidth, double screenHeight) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Domus power monitor\n',
                      style: TextStyle(
                        fontFamily: 'Matrice',
                        fontSize: screenHeight *
                            0.1, // Responsive font size based on height
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: '\nA energia da sua casa, sob o seu controle.',
                      style: TextStyle(
                        fontFamily: 'Matrice',
                        fontSize: screenHeight * 0.05, // Responsive font size
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth * 0.4,
                child: const WelcomeButton(
                  buttonText: 'Entrar',
                  onTap: SignInScreen(),
                  color: Colors.transparent,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenWidth * 0.4,
                child: WelcomeButton(
                  buttonText: 'Inscrever-se',
                  onTap: const SignUpScreen(),
                  color: Colors.white,
                  textColor: lightColorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
