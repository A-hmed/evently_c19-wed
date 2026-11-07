import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/core/theme/app_colors.dart';
import 'package:evently_c19/core/widgets/custom_back_btn.dart';
import 'package:evently_c19/core/widgets/custom_btn.dart';
import 'package:evently_c19/l10n/app_localizations.dart';
import 'package:evently_c19/model/onboarding_dm.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;
  late ThemeData theme;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///Get the theme every build because the user may change it in the start screen
    theme = Theme.of(context);
    var onboardingList = OnboardingDM.getOnboardingList(context);
    var isLastPage = currentIndex == onboardingList.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              buildAppBarRow(isLastPage),
              SizedBox(height: 24),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onboardingList.length,
                  onPageChanged: (index) {
                    currentIndex = index;
                    setState(() {});
                  },
                  itemBuilder: (context, index) => buildOnboardingPage(
                    onboardingList[index],
                    onboardingList.length,
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomBtn(
                text: isLastPage
                    ? AppLocalizations.of(context)!.getStarted
                    : AppLocalizations.of(context)!.next,
                onTap: () {
                  if (isLastPage) {
                    Navigator.pushReplacement(context, AppRoutes.login());
                  } else {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBarRow(bool isLastPage) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: currentIndex == 0
              ? null
              : Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CustomBackBtn(
                    onTap: () {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
        ),
        Expanded(
          child: Center(
            child: Hero(
              tag: "logo",
              child: Image.asset("assets/logo/app_logo.png", width: 140),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          child: isLastPage
              ? null
              : InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, AppRoutes.login());
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.skip,
                        style: TextStyle(
                          color: AppColors.lightPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget buildOnboardingPage(OnboardingDM onboarding, int pagesCount) {
    ///The design frame is 393 wide, so the text scales with the screen width
    ///to keep the same proportions as the design on every phone
    var textScale = (MediaQuery.sizeOf(context).width / 393).clamp(0.85, 1.2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            ///The scale keeps all the images at the same relative size as the
            ///design, and they still shrink to fit on smaller screens
            child: Image.asset(
              onboarding.image,
              scale: 2.14,
              color: theme.primaryColorLight,
            ),
          ),
        ),
        SizedBox(height: 24),
        Center(child: buildDotsIndicator(pagesCount)),
        SizedBox(height: 24),
        Text(
          onboarding.title,
          style: theme.textTheme.titleMedium?.copyWith(fontSize: 20 * textScale),
        ),
        SizedBox(height: 8),
        Text(
          onboarding.description,
          style: TextStyle(
            fontSize: 16 * textScale,
            height: 1.5,
            color: AppColors.grayColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget buildDotsIndicator(int pagesCount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pagesCount, (index) {
        var isSelected = index == currentIndex;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isSelected ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isSelected
                ? theme.primaryColor
                : AppColors.grayColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
