import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/features/onboarding/domain/model/onboarding_section.dart';

class OnboardingSectionWidget extends StatelessWidget {
  final OnboardingSection onboardingSection;

  const OnboardingSectionWidget({super.key, required this.onboardingSection});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .stretch, // Equivalent to Modifier.fillMaxWidth() for children
      children: <Widget>[
        // Spacer(90.dp)
        const SizedBox(height: 90.0),

        Image.asset(
          onboardingSection.imagePath,
          fit: BoxFit.contain,
          width: double.infinity,
          height: 300, // Optional: fixed height to prevent excessive stretching
        ),

        const SizedBox(height: 80.0),

        // Text (Title)
        Text(
          onboardingSection.title,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 30.0),

        Text(
          onboardingSection.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}
