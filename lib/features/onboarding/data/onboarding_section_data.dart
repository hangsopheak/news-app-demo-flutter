// Utility class to provide static access to the main onboarding flow data.


import 'package:news_app_demo_flutter/features/onboarding/domain/model/onboarding_section.dart';

class OnboardingSectionData {
  // We use static methods/fields instead of a Kotlin 'object' class.

  static List<OnboardingSection> getMainOnboardingSections() {
    return const [
      // =============================================================================
      // SECTION 1: Stay Informed & Updated
      // R.drawable.onboarding_section1 is replaced with the asset path.
      // Assuming you converted the XML drawable to SVG and placed it in assets/images/.
      // =============================================================================
      OnboardingSection(
        title: "Stay Informed",
        subtitle: "Breaking News at Your Fingertips",
        description:
            "Get the latest breaking news, trending stories, and real-time updates from trusted sources around the world. Never miss what matters most to you.",
        imagePath: 'assets/images/onboarding_section1.png',
      ),

      // =============================================================================
      // SECTION 2: Personalized Experience
      // =============================================================================
      OnboardingSection(
        title: "Your News, Your Way",
        subtitle: "Personalized Content Just for You",
        description:
            "Choose from multiple categories like Technology, Sports, Business, Entertainment, and Health. Get news recommendations tailored to your interests and reading habits.",
        imagePath: 'assets/images/onboarding_section2.png',
      ),

      // =============================================================================
      // SECTION 3: Save & Share
      // =============================================================================
      OnboardingSection(
        title: "Save & Share",
        subtitle: "Bookmark and Connect",
        description:
            "Bookmark your favorite articles to read later, even offline. Share interesting stories with friends and family across all your social platforms with just one tap.",
        imagePath: 'assets/images/onboarding_section3.png',
      ),
    ];
  }
}
