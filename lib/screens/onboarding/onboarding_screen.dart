import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plant_identification_app/providers/auth_provider.dart';
import 'package:plant_identification_app/providers/onboarding_provider.dart';
import 'package:plant_identification_app/screens/auth/login_screen.dart';
import 'package:plant_identification_app/screens/onboarding/onboarding_pages.dart';
import 'package:plant_identification_app/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    final onboardingProvider = Provider.of<OnboardingProvider>(context, listen: false);
    
    if (onboardingProvider.isLastPage) {
      // Complete onboarding
      Provider.of<AuthProvider>(context, listen: false).completeOnboarding();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      // Go to next page
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onSkipPressed() {
    // Skip to last page
    final onboardingProvider = Provider.of<OnboardingProvider>(context, listen: false);
    _pageController.animateToPage(
      onboardingProvider.totalPages - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final onboardingProvider = Provider.of<OnboardingProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: onboardingProvider.isLastPage ? null : _onSkipPressed,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: onboardingProvider.isLastPage
                          ? Colors.transparent
                          : AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  onboardingProvider.goToPage(index);
                },
                children: const [
                  OnboardingWelcomePage(),
                  OnboardingDataPrivacyPage(),
                  OnboardingPermissionsPage(),
                  OnboardingPreferencesPage(),
                  OnboardingCompletePage(),
                ],
              ),
            ),
            // Page indicator and buttons
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingProvider.totalPages,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: index == onboardingProvider.currentPage ? 24.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: index == onboardingProvider.currentPage
                              ? AppTheme.primaryColor
                              : AppTheme.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(),
                  const SizedBox(height: 32),
                  // Next/Get Started button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      child: Text(
                        onboardingProvider.isLastPage ? 'GET STARTED' : 'NEXT',
                      ),
                    ),
                  ).animate().fadeIn().moveY(begin: 20, end: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}