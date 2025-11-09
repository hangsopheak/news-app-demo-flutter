import 'package:flutter/material.dart';
import 'package:news_app_demo_flutter/features/onboarding/data/onboarding_section_data.dart';
import 'package:news_app_demo_flutter/features/onboarding/utils/onboarding_util.dart';
import 'widgets/onboarding_button_widget.dart';
import 'widgets/onboarding_indicator_widget.dart';
import 'widgets/onboarding_section_widget.dart';
import 'package:news_app_demo_flutter/features/auth/ui/login_screen.dart'; // added import

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sections = OnboardingSectionData.getMainOnboardingSections();
    final int lastPage = sections.length - 1;

    // Button state logic
    String leftButtonText = '';
    String rightButtonText = '';
    if (_currentPage == 0) {
      leftButtonText = '';
      rightButtonText = 'Next';
    } else if (_currentPage == lastPage) {
      leftButtonText = 'Back';
      rightButtonText = 'Start';
    } else {
      leftButtonText = 'Back';
      rightButtonText = 'Next';
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: sections.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: OnboardingSectionWidget(
                      onboardingSection: sections[index],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16, top: 8),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Row(
                    // We still use spaceBetween to push elements to the edges,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 1. LEFT BUTTON (Wrapped in Expanded)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: leftButtonText.isNotEmpty
                              ? OnboardingButtonWidget(
                            text: leftButtonText,
                            onPressed: () {
                              if (_currentPage > 0) {
                                _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                            },
                            backgroundColor: Colors.white,
                            textColor: Colors.black54,
                          )
                              : const SizedBox.shrink(), // Use SizedBox.shrink for zero size
                        ),
                      ),

                      // 2. CENTER INDICATOR
                      // The Center widget ensures the indicator is aligned centrally within the Row's main axis.
                      Center(
                        child: OnboardingIndicatorWidget(
                          pageSize: sections.length,
                          currentPage: _currentPage
                        ),
                      ),

                      // 3. RIGHT BUTTON (Wrapped in Expanded)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: OnboardingButtonWidget(
                            text: rightButtonText,
                            onPressed: () async {
                              if (_currentPage < lastPage) {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              } else {
                                // await setting onboarding completed, then navigate to login
                                await OnboardingUtil.setOnboardingCompleted();

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
