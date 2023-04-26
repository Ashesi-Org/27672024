import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mainscreens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ashesi Social Network',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFAB3C43,
          <int, Color>{
            50: Color(0xFFFFF3F3),
            100: Color(0xFFFFD7D9),
            200: Color(0xFFFBA6A9),
            300: Color(0xFFF87479),
            400: Color(0xFFF24C5B),
            500: Color(0xFFAB3C43),
            600: Color(0xFF7E2F34),
            700: Color(0xFF5E252A),
            800: Color(0xFF461D22),
            900: Color(0xFF33171C),
          },
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme
        ).apply(
            bodyColor: Colors.black
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
        }),
      ),
      home: const HomeScreen(),
    );
  }
}

