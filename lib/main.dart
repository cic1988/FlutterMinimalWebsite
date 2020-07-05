import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:minimal/pages/pages.dart';

import 'pages/pages.dart';
import 'pages/pages.dart';
import 'pages/pages.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1000,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == QuestionOverviewPage.routeName) {
          final String id = settings.arguments.toString();

          return MaterialPageRoute(
            builder: (context) {
              return QuestionOverviewPage(id: num.parse(id));
            },
          );
        } else {
          return MaterialPageRoute(
            builder: (context) {
              return HotRankList();
            },
          );
        }
      },
      theme: Theme.of(context).copyWith(platform: TargetPlatform.android),
      debugShowCheckedModeBanner: false,
    );
  }
}
