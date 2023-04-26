import 'package:flutter/material.dart';
import 'package:webtech_flutter_app/authentication/login_screen.dart';

import '../mainscreens/HTTPhelper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  HTTPHelper  httpHelper = HTTPHelper();
  String studentId = "";
  String name = "";
  String email = "";
  DateTime selectedDate = DateTime.now();
  String yearGroup = "";
  String major = "";
  String residenceStatus = "";
  String bestFood = "";
  String bestMovie = "";
  String password = "";


  final studentIdController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final selectedDateController = TextEditingController();
  final yearGroupController = TextEditingController();
  final majorController = TextEditingController();
  final residenceStatusController = TextEditingController();
  final bestFoodController = TextEditingController();
  final bestMovieController = TextEditingController();
  final passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFab3c43),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/ashesilogo.png',
                        width: 150,
                        height: 150,
                      ),
                      // studentId text-field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Student Id",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            controller: studentIdController,
                            style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Student Id",
                              prefixIcon: Icon(Icons.person, color: Color(0xffab3c43)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // name text-field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            controller: nameController,
                            style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Name",
                              prefixIcon: Icon(Icons.account_circle, color: Color(0xffab3c43)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //email textfield
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Email",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Email",
                              prefixIcon: Icon(Icons.alternate_email, color: Color(0xffab3c43)),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20,),
                      //dateOfBirth
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date of Birth",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Date Of Birth",
                              prefixIcon: Icon(Icons.date_range_sharp, color: Color(0xffab3c43)),
                            ),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null && picked != selectedDate) {
                                setState(() {
                                  selectedDate = picked;
                                });
                              }
                            },
                            controller: TextEditingController(text: selectedDate.toString().split(" ")[0]),
                            readOnly: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),


                      //yearGroup text-field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Year Group",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            controller: yearGroupController,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Year Group",
                              prefixIcon: Icon(Icons.book_online_rounded, color: Color(0xffab3c43)),
                              // icon: Icon(
                              //   Icons.email,
                              //   color: Colors.white,
                              // )
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20,),

                      //residenceStatus text-field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Residence Status",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            controller: residenceStatusController,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Campus/Off-campus",
                              prefixIcon: Icon(Icons.house_rounded, color: Color(0xffab3c43)),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20,),
                      //bestMovie text-field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Best Movie",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            controller: bestMovieController,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Best Movie",
                              prefixIcon: Icon(Icons.movie_rounded, color: Color(0xffab3c43)),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20,),

                      //bestFood text-field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Best Food",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            controller: bestFoodController,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Best Food",
                              prefixIcon: Icon(Icons.fastfood_rounded, color: Color(0xffab3c43)),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20,),

                      // Password
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: true, // setting obscureText to true
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock, color: Color(0xffab3c43)), // updated prefix icon
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20,),


                      //  Button
                      ElevatedButton(
                        onPressed: () async {
                          bool response = await httpHelper.createProfile(
                            studentIdController.text,
                            nameController.text,
                            emailController.text,
                            selectedDateController.text,
                            yearGroupController.text,
                            majorController.text,
                            residenceStatusController.text,
                            bestFoodController.text,
                            bestMovieController.text,
                            passwordController.text,
                          );
                          if (response) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile created successfully')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to create profile')));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width * .5, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        child: const Text(
                          'Create Profile',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),

                      const SizedBox(height: 20,),


                      GestureDetector(

                        onTap: () {
                          // Handle login redirect link press
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()));

                        },
                        child: const Text(
                          'Already have an account?  Login here',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
