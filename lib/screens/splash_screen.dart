import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Duration delayInterval = const Duration(milliseconds: 3000);

  @override
  void initState() {
    super.initState();
    wait();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            (MediaQuery.of(context).platformBrightness == Brightness.light)
                ? Colors.white
                : const Color(0xff282828),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/crypto_graph.json'),
            Text(
              'CRYPTO TRACKER',
              style: GoogleFonts.getFont(
                'Architects Daughter',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void wait() async {
    await Future.delayed(delayInterval);
    Future(
      () => Navigator.of(context).pushReplacementNamed('/dashBoard'),
    );
  }
}
