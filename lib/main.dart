import 'package:crypto_app/screens/dashboard_screen.dart';
import 'package:crypto_app/screens/splash_screen.dart';
import 'package:crypto_app/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      home: const DashBoardScreen(),
      onGenerateRoute: (RouteSettings settings) {
        debugPrint('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          '/splash': (BuildContext context) => const SplashScreen(),
          '/dashBoard': (BuildContext context) => const DashBoardScreen(),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(
          builder: (ctx) => builder(ctx),
        );
      },
    );
  }
}
