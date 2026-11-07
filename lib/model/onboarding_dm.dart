import 'package:evently_c19/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnboardingDM {
  final String image;
  final String title;
  final String description;

  const OnboardingDM({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnboardingDM> getOnboardingList(BuildContext context) => [
    OnboardingDM(
      image: 'assets/images/onboarding_1.png',
      title: AppLocalizations.of(context)!.onboardingTitle1,
      description: AppLocalizations.of(context)!.onboardingDescription1,
    ),
    OnboardingDM(
      image: 'assets/images/onboarding_2.png',
      title: AppLocalizations.of(context)!.onboardingTitle2,
      description: AppLocalizations.of(context)!.onboardingDescription2,
    ),
    OnboardingDM(
      image: 'assets/images/onboarding_3.png',
      title: AppLocalizations.of(context)!.onboardingTitle3,
      description: AppLocalizations.of(context)!.onboardingDescription3,
    ),
  ];
}
