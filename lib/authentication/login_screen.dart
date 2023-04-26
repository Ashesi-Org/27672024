import 'package:flutter/material.dart';
import 'package:webtech_flutter_app/authentication/dashboard_screen.dart';
import 'package:webtech_flutter_app/authentication/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String studentId = "";
  String password = "";


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
                            onChanged: (value) {
                              studentId = value;
                            },
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
                            onChanged: (value) {
                              password = value;
                            },
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
                        onPressed: () {
                          // Handle sign-up button press
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const DashboardScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                          Size(MediaQuery.of(context).size.width * .5, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20,),


                      GestureDetector(
                        onTap: () {
                          // Handle login redirect link press
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()));


                        },
                        child: const Text(
                          "Don't have an account?  Sign Up here",
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
