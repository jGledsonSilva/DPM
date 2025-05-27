import 'package:flutter/material.dart';

// 1. Convertido para StatefulWidget
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // 2. Variável de estado para controlar a aparência do botão
  bool _isGetStartedPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Estilo base comum para os botões
    final ButtonStyle baseButtonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );

    // Estilo do botão "Get Started" antes do clique
    final ButtonStyle initialGetStartedStyle = baseButtonStyle.copyWith(
      backgroundColor: MaterialStateProperty.all(colors.surface),
      foregroundColor: MaterialStateProperty.all(colors.onSurface),
      elevation: MaterialStateProperty.all(2.0), // Elevação padrão ou desejada
    );

    // Estilo do botão "Get Started" após o clique
    // Para se assemelhar aos campos de texto da signup_page (brancos/claros, sem elevação)
    // signup_page usa colors.surfaceContainerHighest.withOpacity(0.5) para os TextFields
    final ButtonStyle pressedGetStartedStyle = baseButtonStyle.copyWith(
      backgroundColor: MaterialStateProperty.all(
          colors.surfaceContainerHighest.withOpacity(0.5)),
      foregroundColor:
          MaterialStateProperty.all(colors.onSurface), // Manter a cor do texto
      elevation: MaterialStateProperty.all(0), // Sem elevação
      side: MaterialStateProperty.all(
          BorderSide.none), // Sem borda, como os TextFields
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primaryContainer, colors.secondaryContainer],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Logo (similar to the one in the image)
                  Icon(
                    Icons.account_circle, // Placeholder for the logo
                    size: 100,
                    color: colors.onPrimaryContainer,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Name.App',
                    textAlign: TextAlign.center,
                    style: textTheme.displayMedium?.copyWith(
                        color: colors.onPrimaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    // 4. Aplicar estilo condicional
                    style: _isGetStartedPressed
                        ? pressedGetStartedStyle
                        : initialGetStartedStyle,
                    onPressed: () {
                      // 3. Atualizar estado e navegar após um delay
                      setState(() {
                        _isGetStartedPressed = true;
                      });
                      Future.delayed(const Duration(milliseconds: 300), () {
                        if (mounted) {
                          // Garante que o widget ainda está na árvore
                          Navigator.pushNamed(context, '/signup');
                          // Opcional: resetar o estado se o usuário puder voltar e o botão deva estar normal
                          // No entanto, se a página for reconstruída ao voltar, o estado será resetado.
                          // Se a página não for reconstruída e o botão precisar voltar ao normal,
                          // seria necessário um setState aqui ou em um `didPopNext`.
                          // setState(() {
                          //  _isGetStartedPressed = false;
                          // });
                        }
                      });
                    },
                    child: const Text('Get Started'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page if it exists, or handle directly
                      // For now, let's assume it navigates to SignUpPage as well or a dedicated LoginPage
                      Navigator.pushNamed(context,
                          '/signup'); // Or a dedicated login page if you create one
                    },
                    child: Text(
                      'I already have an account',
                      style: textTheme.bodyMedium?.copyWith(
                          color: colors.onPrimaryContainer.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
