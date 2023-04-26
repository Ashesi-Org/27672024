import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:webtech_flutter_app/authentication/login_screen.dart';

import '../authentication/register_screen.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  String timeText = "";
  String dateText = "";

  String formatCurrentLiveTime(DateTime time)
  {
    return DateFormat("hh:mm:ss a").format(time);
  }
  String formatCurrentLiveDate(DateTime date)
  {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime()
  {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentLiveDate(timeNow);
    if(this.mounted)
    {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState()
  {
    super.initState();

    //  date
    dateText = formatCurrentLiveDate(DateTime.now());
    //  time
    timeText = formatCurrentLiveTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (timer)
    {
      getCurrentLiveTime();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome to Ashesi Social Network",
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage('assets/images/cfair.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.darken),
          ),
        ),
        child: Center(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(150.0),
                child: Text(
                  "$timeText\n$dateText",
                  style: GoogleFonts.montserrat(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),

              ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle sign-up button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(160, 80), // Set minimum width and height
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20, // Set the font size to 20
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle sign-up button press
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(160, 80), // Set minimum width and height
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 20, // Set the font size to 20
                  ),
                ),
              ),
              ],
          ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
