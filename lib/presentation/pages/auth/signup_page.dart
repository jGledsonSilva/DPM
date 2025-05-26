import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false;
  bool _isPasswordVisible = false;

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Logo (similar to the one in the image)
                  Icon(
                    Icons.account_circle, // Placeholder for the logo
                    size: 80,
                    color: colors.onPrimaryContainer,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'hello!',
                    textAlign: TextAlign.center,
                    style: textTheme.displaySmall?.copyWith(color: colors.onPrimaryContainer, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildTextField(
                          hintText: 'Username',
                          prefixIcon: Icons.person_outline,
                          colors: colors,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          hintText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          colors: colors,
                        ),
                        const SizedBox(height: 16),
                        _buildPasswordField(colors),
                        const SizedBox(height: 20),
                        _buildTermsAndConditionsCheckbox(colors, textTheme),
                        const SizedBox(height: 30),
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
                            if (_formKey.currentState!.validate()) {
                              if (!_agreeToTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please agree to the terms and conditions')),
                                );
                                return;
                              }
                              // Process sign up
                            }
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Expanded(child: Divider(color: colors.outlineVariant)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('or', style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
                      ),
                      Expanded(child: Divider(color: colors.outlineVariant)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Log in with your social media account',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(color: colors.onPrimaryContainer),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildSocialButton(Colors.red, colors),
                      const SizedBox(width: 20),
                      _buildSocialButton(Colors.yellow, colors),
                      const SizedBox(width: 20),
                      _buildSocialButton(Colors.blue, colors),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    required ColorScheme colors,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(color: colors.onSurface),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: colors.onSurfaceVariant),
        prefixIcon: Icon(prefixIcon, color: colors.primary),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: colors.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        if (hintText == 'Email' && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(ColorScheme colors) {
    return TextFormField(
      obscureText: !_isPasswordVisible,
      style: TextStyle(color: colors.onSurface),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(color: colors.onSurfaceVariant),
        prefixIcon: Icon(Icons.lock_outline, color: colors.primary),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: colors.primary,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        filled: true,
        fillColor: colors.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildTermsAndConditionsCheckbox(ColorScheme colors, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: _agreeToTerms,
          onChanged: (bool? value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
          checkColor: colors.onPrimary,
          activeColor: colors.primary,
          side: BorderSide(color: colors.onPrimaryContainer),
        ),
        Text(
          'I agree to the terms and conditions',
          style: textTheme.bodySmall?.copyWith(color: colors.onPrimaryContainer),
        ),
      ],
    );
  }

  Widget _buildSocialButton(Color color, ColorScheme colors) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(Icons.login, color: colors.onInverseSurface), // Adjusted for better contrast with button color
        onPressed: () {
          // Handle social login
        },
      ),
    );
  }
}
