import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/themeColors.dart';
import 'features/home/presentation/home_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboard = prefs.getBool('seenOnboard') ?? false;
  runApp(MyApp(seenOnboard: seenOnboard));
}

class MyApp extends StatelessWidget {
  final bool seenOnboard;

  MyApp({required this.seenOnboard});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Articles App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: seenOnboard ? HomePage() : OnboardingPage(),
    );
  }
}

void goToHome(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('seenOnboard', true);
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => HomePage()),
  );
}

class OnboardingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Welcome to Articles App. Your go-to place for articles.",
          image: Center(child: Icon(Icons.article, size: 175, color: primaryColor,)),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Discover",
          body: "Discover articles on various topics.",
          image: Center(child: Icon(Icons.search, size: 175, color: primaryColor)),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Read",
          body: "Read and enjoy the articles.",
          image: Center(child: Icon(Icons.book, size: 175, color: primaryColor)),
          decoration: getPageDecoration(),
        ),
      ],
      onDone: () => goToHome(context),
      onSkip: () => goToHome(context),
      showSkipButton: true,
      skip: const Icon(Icons.skip_next, color: Colors.orange),
      next: const Icon(Icons.navigate_next, color: Colors.orange),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: getDotsDecorator(),
    );
  }

  void goToHome(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  DotsDecorator getDotsDecorator() => DotsDecorator(
    color: Colors.black87,
    activeColor: primaryColor,
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: PageDecoration().titleTextStyle.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: primaryColor
    ),
    bodyTextStyle: PageDecoration().bodyTextStyle.copyWith(fontSize: 20),
    // descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(24),
    pageColor: secondaryColor,
  );
}




