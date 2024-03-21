import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF9BC688),
        title: SvgPicture.asset(
          "assets/icons/logo_prestasiku.svg",
          height: 30.0,
        ),
      ),
      body: IntroductionScreen(
        showNextButton: true,
        showDoneButton: false,
        showBackButton: true,
        globalBackgroundColor: Color(0XFF9BC688),
        next: const Icon(Icons.arrow_forward),
        nextStyle: TextButton.styleFrom(primary: Color(0XFF165F23)),
        back: const Icon(Icons.arrow_back),
        backStyle: TextButton.styleFrom(primary: Color(0XFF165F23)),
        dotsDecorator: DotsDecorator(
          activeColor: Color(0XFFFFFFFF),
          color: Color(0XFF165F23),
        ),
        pages: [
          PageViewModel(
            title: "Halo!",
            body: "Selamat datang di aplikasi Prestasiku",
            image: Image.asset(
              "assets/image/Standing waving.png",
              height: 200.0,
            ),
            decoration: const PageDecoration(pageColor: Color(0XFF9BC688)),
          ),
          PageViewModel(
            title: "Hmmm...",
            body:
                "Apa kamu ingin meraih beasiswa dan mengikuti lomba impian kamu??",
            image: Image.asset("assets/image/Thinking.png", height: 200.0),
            decoration: const PageDecoration(pageColor: Color(0XFF9BC688)),
          ),
          PageViewModel(
            title: "Tenang..",
            body:
                "Dengan aplikasi PrestasiKu, kamu dapat dengan mudah menemukan berbagai kompetisi dan lomba menarik yang sesuai dengan minat dan bakat kamu, lho.",
            image:
                Image.asset("assets/image/Sitting relaxed.png", height: 175.0),
            decoration: const PageDecoration(pageColor: Color(0XFF9BC688)),
          ),
          PageViewModel(
            title: "Jadi, tunggu apa lagi?",
            body: "Jangan lewatkan kesempatan untuk meraih prestasi dan mari mulai mengejar impian kamu!",
            image: Image.asset("assets/image/Standing pointing down.png",
                height: 175.0),
            decoration: const PageDecoration(pageColor: Color(0XFF9BC688)),
            reverse: true,
            footer: Padding(
                padding: EdgeInsets.all(50),
                child: ElevatedButton(
                    // * Go route to "/signin"
                    onPressed: () => GoRouter.of(context).go('/signin'),
                    child: Text("Ayo Mulai PrestasiMu!"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFF165F23),
                        foregroundColor: Colors.white))),
          ),
        ],
      ),
    );
  }
}
