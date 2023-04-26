import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:webtech_flutter_app/authentication/Seepost.dart';
import 'package:webtech_flutter_app/authentication/login_screen.dart';
import 'package:webtech_flutter_app/authentication/profileview.dart';

import '../authentication/register_screen.dart';
import 'createpost.dart';
import 'editprofile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String timeText = "";
  String dateText = "";
  late Map<String, dynamic> thisItem = {
    'studentId': '27672024',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Dashboard",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePage(studentId: '27672024')),
                      );
                      },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(250, 250)),
                    ),
                    child: const Text('View Profile'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfilePage(studentId: '27672024',)));

                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(250, 250)),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CreatePostScreen()));
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(250, 250)),
                    ),
                    child: const Text('Create Post'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PostsList()));
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(250, 250)),
                    ),
                    child: const Text('See Posts'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
