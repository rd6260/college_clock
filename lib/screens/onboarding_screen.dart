// import 'package:college_clock/screens/full_table_screen.dart';
import 'package:college_clock/screens/home_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagesPath {
  static String kOnboarding1 = 'assets/onboarding/onboarding1.png';
  static String kOnboarding2 = 'assets/onboarding/onBoarding2.png';
  static String kOnboarding3 = 'assets/onboarding/onBoarding3.png';
}

class AppColor {
  static Color kPrimary = const Color(0XFF1460F2);
  static Color kWhite = const Color(0XFFFFFFFF);
  static Color kOnBoardingColor = const Color(0XFFFEFEFE);
  static Color kGrayscale40 = const Color(0XFFAEAEB2);
  static Color kGrayscaleDark100 = const Color(0XFF1C1C1E);
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  void onGetStarted() {
    if (_currentIndex == onBoardinglist.length - 1) {
      onCompleteOnboarding(context);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void onCompleteOnboarding(BuildContext context) async {
    if (!context.mounted) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Navigator.of(
      // ignore: use_build_context_synchronously
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kOnBoardingColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.kPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            // flex: 5,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: onBoardinglist.length,
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnBoardingCard(onBoardingModel: onBoardinglist[index]);
              },
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: DotsIndicator(
              dotsCount: onBoardinglist.length,
              position: _currentIndex.toDouble(),
              decorator: DotsDecorator(
                color: AppColor.kPrimary.withValues(alpha: 0.4),
                size: const Size.square(8.0),
                activeSize: const Size(20.0, 8.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: AppColor.kPrimary,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 23, bottom: 36),
            child: PrimaryButton(
              elevation: 0,
              onTap: onGetStarted,
              text:
                  _currentIndex == onBoardinglist.length - 1
                      ? 'Get Started'
                      : 'Next',
              bgColor: AppColor.kPrimary,
              borderRadius: 20,
              height: 46,
              width: double.infinity,
              textColor: AppColor.kWhite,
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius, elevation;
  final double? fontSize;
  final IconData? iconData;
  final Color? textColor, bgColor;
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.elevation = 5,
    this.borderRadius,
    this.fontSize,
    required this.textColor,
    required this.bgColor,
    this.iconData,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: widget.elevation ?? 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: Text(
              widget.text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.kWhite,
              ).copyWith(
                color: widget.textColor,
                fontWeight: FontWeight.w500,
                fontSize: widget.fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingCard extends StatefulWidget {
  final OnBoardingModel onBoardingModel;
  const OnBoardingCard({super.key, required this.onBoardingModel});

  @override
  State<OnBoardingCard> createState() => _OnBoardingCardState();
}

class _OnBoardingCardState extends State<OnBoardingCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SizedBox()),
        Image.asset(
          widget.onBoardingModel.image,
          height: 300,
          width: double.maxFinite,
          fit: BoxFit.fitWidth,
        ),
        Expanded(child: SizedBox()),
        OnboardingTextCard(onBoardingModel: widget.onBoardingModel),
      ],
    );
  }
}

class OnboardingTextCard extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const OnboardingTextCard({required this.onBoardingModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        children: [
          Text(
            onBoardingModel.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.kGrayscaleDark100,
            ).copyWith(fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            onBoardingModel.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.kWhite,
            ).copyWith(color: AppColor.kGrayscale40, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class OnBoardingModel {
  String title;
  String description;
  String image;

  OnBoardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnBoardingModel> onBoardinglist = [
  OnBoardingModel(
    title: 'Kya aap bhi college ke google sheet for timetable se pareshan hai?',
    image: ImagesPath.kOnboarding1,
    description:
        'BC itna hard to look at hai sheet use krna for timetable. Kash kuch better looking mil jaata',
  ),
  OnBoardingModel(
    title: 'Idhar kuch dalna padega',
    image: ImagesPath.kOnboarding2,
    description: "toh dalo na kuch madarchod!!!!",
  ),
  OnBoardingModel(
    title: "aab idhar kya lagu",
    image: ImagesPath.kOnboarding3,
    description: "kuch bhi dalde bhai",
  ),
];
