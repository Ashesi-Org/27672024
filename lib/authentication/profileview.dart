import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String studentId;

  const ProfilePage({Key? key, required this.studentId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _futureProfile;

  @override
  void initState() {
    super.initState();
    _futureProfile = fetchProfile(widget.studentId);
  }

  Future<Map<String, dynamic>> fetchProfile(String studentId) async {
    final url =
    Uri.parse('http://127.0.0.1:200/profiles?studentId=$studentId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor:  const Color(0xFFab3c43),
        appBar: AppBar(
          title: Text('View Profile'),
        ),
        body: Center(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _futureProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'name: ${data['name']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'email: ${data['email']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'bestFood: ${data['bestFood']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'bestMovie: ${data['bestMovie']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'dateOfBirth: ${data['dateOfBirth']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'major: ${data['major']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'password: ${data['password']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'residenceStatus: ${data['residenceStatus']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'studentId: ${data['studentId']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'yearGroup: ${data['yearGroup']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),

                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
