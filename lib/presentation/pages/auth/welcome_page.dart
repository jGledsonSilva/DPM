import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                    style: textTheme.displayMedium?.copyWith(color: colors.onPrimaryContainer, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.surface,
                      foregroundColor: colors.onSurface,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup'); // Navigate to SignUpPage
                    },
                    child: const Text('Get Started'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page if it exists, or handle directly
                      // For now, let's assume it navigates to SignUpPage as well or a dedicated LoginPage
                       Navigator.pushNamed(context, '/signup'); // Or a dedicated login page if you create one
                    },
                    child: Text(
                      'I already have an account',
                      style: textTheme.bodyMedium?.copyWith(color: colors.onPrimaryContainer.withOpacity(0.7)),
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
