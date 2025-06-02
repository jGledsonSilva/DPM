import 'package:dpm/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

// 1. Convertido para StatefulWidget
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // 2. Variável de estado para controlar a animação
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    final strings = AppLocalizations.of(context); // Adicionado para localização

    final Duration animationDuration = const Duration(milliseconds: 300);
    // A navegação deve ocorrer após a animação principal
    final Duration navigationDelay = const Duration(milliseconds: 350);

    // Estilo do botão "Get Started" (não mais condicional aqui, pois o botão some)
    final ButtonStyle initialGetStartedStyle = ElevatedButton.styleFrom(
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      elevation: 2.0,
    );

    return Scaffold(
      body: Stack(
        children: [
          // 1. Fundo gradiente original (desaparece)
          AnimatedOpacity(
            opacity: _isAnimating ? 0.0 : 1.0,
            duration: animationDuration,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.primaryContainer, colors.secondaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // 2. Camada de fundo branco que aparece (simulando o botão se tornando o fundo)
          AnimatedOpacity(
            opacity: _isAnimating ? 1.0 : 0.0,
            duration: animationDuration,
            child: Container(
              color: colors.surface, // Este será o fundo da tela de login
            ),
          ),

          // 3. Conteúdo da WelcomePage (logo, tagline, botões)
          // Este conteúdo se move e/ou desaparece
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Espaçador animado para mover o logo para cima
                  AnimatedContainer(
                    duration: animationDuration, // Adicionado duration
                    curve: Curves.easeInOut, // Adicionado curve
                    height: screenSize.height * (_isAnimating ? 0.12 : 0.25),
                  ),

                  Align(
                    alignment: Alignment.center, // Centraliza o logo
                    child: AnimatedOpacity(
                      opacity: _isAnimating ? 0.0 : 1.0,
                      duration: animationDuration,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png', // Caminho do logo
                            height: screenSize.height * 0.15, // Tamanho do logo
                          ),
                          const SizedBox(height: 8),
                          Text(
                            strings.appTitle, // Usando string localizada
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _isAnimating
                                  ? colors.surface
                                  : colors.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedOpacity(
                    opacity: _isAnimating ? 0.0 : 1.0,
                    duration: animationDuration,
                    child: Text(
                      strings.welcomeTagline, // Usando string localizada
                      textAlign: TextAlign.center,
                      style: textTheme.titleMedium?.copyWith(
                        color: _isAnimating
                            ? colors.surface
                            : colors.onBackground.withOpacity(0.7),
                      ),
                    ),
                  ),

                  const Spacer(), // Empurra os botões para baixo

                  // Botão "Get Started"
                  AnimatedOpacity(
                    opacity: _isAnimating ? 0.0 : 1.0,
                    duration: animationDuration,
                    child: ElevatedButton(
                      style: initialGetStartedStyle,
                      onPressed: () {
                        setState(() {
                          _isAnimating = true;
                        });
                        Future.delayed(navigationDelay, () {
                          Navigator.pushNamed(context, '/signup');
                        });
                      },
                      child: Text(
                          strings.getStartedButton), // Usando string localizada
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _isAnimating ? 0.0 : 1.0,
                    duration: animationDuration,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implementar navegação para a página de login
                        // Por enquanto, vamos simular a animação e ir para signup também
                        setState(() {
                          _isAnimating = true;
                        });
                        Future.delayed(navigationDelay, () {
                          // Idealmente, navegar para a tela de login
                          Navigator.pushNamed(context, '/signup');
                        });
                      },
                      child: Text(
                        strings
                            .alreadyHaveAccountButton, // Usando string localizada
                        style: textTheme.bodyMedium?.copyWith(
                          color: _isAnimating
                              ? colors.surface
                              : colors.onBackground,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
