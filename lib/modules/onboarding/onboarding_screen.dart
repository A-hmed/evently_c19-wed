import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../model/onboarding_dm.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'Find Events That Inspire You',
      description:
          'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_2.png',
      title: 'Effortless Event Planning',
      description:
          'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we\'ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_3.png',
      title: 'Connect with Friends & Share Moments',
      description:
          'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
    ),
  ];

  bool get _isFirstPage => _currentIndex == 0;

  bool get _isLastPage => _currentIndex == _pages.length - 1;

  void _nextPage() {
    if (_isLastPage) {
      Navigator.pushReplacement(context, AppRoutes.login());
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    if (_isFirstPage) return;

    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skip() {
    Navigator.pushReplacement(context, AppRoutes.login());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // ================= TOP BAR =================
              SizedBox(
                height: 42,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Back Button
                    if (!_isFirstPage)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: _previousPage,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),

                    // Logo
                    Image.asset('assets/logo/app_logo.png', width: 140),

                    // Skip
                    if (!_isLastPage)
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _skip,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: theme.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ================= ONBOARDING PAGES =================
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // ================= IMAGE =================
                        Center(
                          child: Image.asset(
                            page.image,
                            width: 343,
                            height: 343,
                            fit: BoxFit.contain,
                            color: theme.primaryColorLight,
                          ),
                        ),
                        // ================= DOTS =================
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(_pages.length, (dotIndex) {
                              final isSelected = _currentIndex == dotIndex;

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: isSelected ? 20 : 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? theme.primaryColor
                                      : AppColors.grayColor.withValues(
                                          alpha: 0.5,
                                        ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            }),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ================= TITLE =================
                        Text(
                          page.title,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // ================= DESCRIPTION =================
                        Text(
                          page.description,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grayColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ================= BUTTON =================
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _isLastPage ? 'Get started' : 'Next',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
