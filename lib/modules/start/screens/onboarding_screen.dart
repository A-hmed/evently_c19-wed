import 'package:evently_c19/modules/start/screens/start_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // هنضيف Login هنا بعد ما نعمل Login Screen.
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skip() {
    // هنضيف Login هنا بعد ما نعمل Login Screen.
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,

      // نخلي التنقل عن طريق الـ buttons فقط.
      physics: const NeverScrollableScrollPhysics(),

      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },

      children: [
        // Page 1
        StartScreen(onNext: _nextPage),

        // Page 2
        _buildOnboardingPage(
          image: "assets/images/illustration_1.png",
          darkImage: "assets/images/illustration_dark_1.png",
          title: "Find Events That Inspire You",
          description:
              "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
          buttonText: "Next",
          showBack: true,
          showSkip: true,
        ),

        // Page 3
        _buildOnboardingPage(
          image: "assets/images/illustration_2.png",
          darkImage: "assets/images/illustration_dark_2.png",
          title: "Effortless Event Planning",
          description:
              "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we've got you covered. Plan with ease and focus on what matters — creating an unforgettable experience for you and your guests.",
          buttonText: "Next",
          showBack: true,
          showSkip: true,
        ),

        // Page 4
        _buildOnboardingPage(
          image: "assets/images/illustration_3.png",
          darkImage: "assets/images/illustration_dark_3.png",
          title: "Connect with Friends & Share Moments",
          description:
              "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
          buttonText: "Get started",
          showBack: true,
          showSkip: false,
        ),
      ],
    );
  }

  Widget _buildOnboardingPage({
    required String image,
    required String darkImage,
    required String title,
    required String description,
    required String buttonText,
    required bool showBack,
    required bool showSkip,
  }) {
    return _OnboardingPage(
      image: image,
      darkImage: darkImage,
      title: title,
      description: description,
      buttonText: buttonText,
      showBack: showBack,
      showSkip: showSkip,
      currentPage: _currentPage,
      onNext: _nextPage,
      onBack: _previousPage,
      onSkip: _skip,
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String image;
  final String darkImage;
  final String title;
  final String description;
  final String buttonText;

  final bool showBack;
  final bool showSkip;

  final int currentPage;

  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onSkip;

  const _OnboardingPage({
    required this.image,
    required this.darkImage,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.showBack,
    required this.showSkip,
    required this.currentPage,
    required this.onNext,
    required this.onBack,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              // =========================
              // Header
              // =========================
              Row(
                children: [
                  if (showBack)
                    IconButton(
                      onPressed: onBack,
                      icon: const Icon(Icons.arrow_back_ios_new),
                    )
                  else
                    const SizedBox(width: 48),

                  const Spacer(),

                  Image.asset("assets/logo/app_logo.png", width: 110),

                  const Spacer(),

                  if (showSkip)
                    TextButton(onPressed: onSkip, child: const Text("Skip"))
                  else
                    const SizedBox(width: 48),
                ],
              ),

              const SizedBox(height: 16),

              // =========================
              // Illustration
              // =========================
              Expanded(
                child: Image.asset(
                  isDark ? darkImage : image,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),

              // =========================
              // Page Indicator
              // =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final isSelected = index == currentPage - 1;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isSelected ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.primaryColor
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),

              // =========================
              // Title
              // =========================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(title, style: theme.textTheme.titleMedium),
              ),

              const SizedBox(height: 8),

              // =========================
              // Description
              // =========================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =========================
              // Button
              // =========================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onNext,
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
