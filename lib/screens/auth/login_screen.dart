import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plant_identification_app/providers/auth_provider.dart';
import 'package:plant_identification_app/screens/auth/signup_screen.dart';
import 'package:plant_identification_app/screens/home_screen.dart';
import 'package:plant_identification_app/theme/app_theme.dart';
import 'package:plant_identification_app/widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await Provider.of<AuthProvider>(context, listen: false)
            .login(_emailController.text, _passwordController.text);

        if (success) {
          // Navigate to home screen
          if (mounted) {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (_) => const HomeScreen())
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid email or password')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Logo and welcome text
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.eco,
                    size: 50,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Welcome to Plantia!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Sign in to continue',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 40),
              // Login form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 600.ms).moveY(begin: 20, end: 0),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Navigate to forgot password screen
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ).animate().fadeIn(delay: 700.ms),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : const Text('LOG IN'),
                      ),
                    ).animate().fadeIn(delay: 800.ms).moveY(begin: 20, end: 0),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Social login options
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Or sign in with',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ).animate().fadeIn(delay: 900.ms),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialLoginButton(
                    icon: Icons.g_mobiledata,
                    color: Colors.red.shade400,
                    onPressed: () {
                      // Google sign in
                    },
                  ),
                  SocialLoginButton(
                    icon: Icons.facebook,
                    color: Colors.blue.shade700,
                    onPressed: () {
                      // Facebook sign in
                    },
                  ),
                  SocialLoginButton(
                    icon: Icons.apple,
                    color: Colors.white,
                    onPressed: () {
                      // Apple sign in
                    },
                  ),
                ],
              ).animate().fadeIn(delay: 1000.ms).moveY(begin: 20, end: 0),
              const SizedBox(height: 40),
              // Sign up option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.secondaryTextColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ).animate().fadeIn(delay: 1100.ms),
            ],
          ),
        ),
      ),
    );
  }
}