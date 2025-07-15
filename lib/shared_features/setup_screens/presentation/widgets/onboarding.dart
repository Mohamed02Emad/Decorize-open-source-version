import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  final List<Widget> onboardings;
  final Function(BuildContext context, int currentPage)? onPageChanged;
  final Widget Function(
    BuildContext context,
    int currentPage,
    Function(int index) setIndex,
  )? buildHeader;

  final Widget Function(
    BuildContext context,
    int currentPage,
    Function(int index) setIndex,
  )? buildFooter;

  const Onboarding({
    super.key,
    required this.onboardings,
    this.onPageChanged,
    this.buildHeader,
    this.buildFooter,
  });

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    _currentPage.value = page;
    if (widget.onPageChanged != null) {
      widget.onPageChanged!(context, page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        if (widget.buildHeader != null)
          ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (context, currentPage, child) {
              return widget.buildHeader?.call(context, currentPage, (index) {
                    _currentPage.value = index;
                    _pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInToLinear);
                  }) ??
                  const SizedBox.shrink();
            },
          ),

        // Content
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: widget.onboardings,
          ),
        ),

        // Footer
        if (widget.buildFooter != null)
          ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (context, currentPage, child) {
              return widget.buildFooter!(context, currentPage, (index) {
                _currentPage.value = index;
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInToLinear);
              });
            },
          ),
      ],
    );
  }
}
