import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plant_identification_app/theme/app_theme.dart';

class OnboardingWelcomePage extends StatelessWidget {
  const OnboardingWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.eco,
              size: 80,
              color: AppTheme.primaryColor,
            ),
          ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
          const SizedBox(height: 40),
          Text(
            'Welcome to Plantia!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 16),
          Text(
            'Identify plants, get care advice, and become a better plant parent with our plant care app.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    );
  }
}

class OnboardingDataPrivacyPage extends StatelessWidget {
  const OnboardingDataPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 80,
              color: AppTheme.primaryColor,
            ),
          ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
          const SizedBox(height: 40),
          Text(
            'Data Privacy',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 16),
          Text(
            'We take your privacy seriously. Your plant data stays on your device, and we only use your photos to identify plants.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 24),
          Text(
            'You can review our full privacy policy anytime in the app settings.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }
}

class OnboardingPermissionsPage extends StatelessWidget {
  const OnboardingPermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: AppTheme.primaryColor,
            ),
          ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
          const SizedBox(height: 40),
          Text(
            'Camera Access',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 16),
          Text(
            'Plantia needs camera access to identify plants and track their growth. We\'ll ask for permission when you start using these features.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppTheme.warningColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'You can change permissions at any time in your device settings.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
        ],
      ),
    );
  }
}

class OnboardingPreferencesPage extends StatelessWidget {
  const OnboardingPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.settings_outlined,
              size: 80,
              color: AppTheme.primaryColor,
            ),
          ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
          const SizedBox(height: 40),
          Text(
            'Customize Your Experience',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 16),
          Text(
            'Tell us about your plant preferences so we can tailor the experience to your needs.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 32),
          // Preference options
          const _PreferenceChip(
            icon: Icons.home_outlined,
            label: 'Indoor Plants',
          ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
          const SizedBox(height: 12),
          const _PreferenceChip(
            icon: Icons.park_outlined,
            label: 'Outdoor Plants',
          ).animate().fadeIn(delay: 600.ms).moveY(begin: 20, end: 0),
          const SizedBox(height: 12),
          const _PreferenceChip(
            icon: Icons.local_florist_outlined,
            label: 'Flowering Plants',
          ).animate().fadeIn(delay: 700.ms).moveY(begin: 20, end: 0),
        ],
      ),
    );
  }
}

class _PreferenceChip extends StatefulWidget {
  final IconData icon;
  final String label;

  const _PreferenceChip({
    required this.icon,
    required this.label,
  });

  @override
  State<_PreferenceChip> createState() => _PreferenceChipState();
}

class _PreferenceChipState extends State<_PreferenceChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: _isSelected ? AppTheme.primaryColor.withOpacity(0.2) : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isSelected ? AppTheme.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: _isSelected ? AppTheme.primaryColor : AppTheme.secondaryTextColor,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                color: _isSelected ? AppTheme.primaryColor : AppTheme.primaryTextColor,
                fontWeight: _isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            Icon(
              _isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: _isSelected ? AppTheme.primaryColor : AppTheme.secondaryTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingCompletePage extends StatelessWidget {
  const OnboardingCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              size: 80,
              color: AppTheme.primaryColor,
            ),
          ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
          const SizedBox(height: 40),
          Text(
            'You\'re All Set!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 16),
          Text(
            'Ready to start identifying and caring for your plants? Let\'s begin your plant journey!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Tip: Take clear photos in good lighting for the best plant identification results.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
        ],
      ),
    );
  }
}