import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../mainscreens/HTTPhelper.dart';

class EditProfilePage extends StatefulWidget {
  final String studentId;

  const EditProfilePage({Key? key, required this.studentId}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Future<Map<String, dynamic>> _futureProfile;
  final TextEditingController residenceStatusController = TextEditingController();
  HTTPHelper  httpHelper = HTTPHelper();

  @override
  void initState() {
    super.initState();
    _futureProfile = fetchProfile(widget.studentId);
  }

  Future<Map<String, dynamic>> fetchProfile(String studentId) async {
    final url = Uri.parse('http://127.0.0.1:200/profiles?studentId=$studentId');
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 400), // Add left and right margins
        child: Center(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _futureProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Column(
                  children: [
                    SizedBox(height: 20), // Add spacing between the widgets
                    TextFormField(
                      initialValue: data['studentId'],
                      decoration: InputDecoration(
                        labelText: 'studentId',
                        contentPadding: EdgeInsets.symmetric(vertical: 5), // Reduce vertical padding
                      ),
                      onChanged: (value) {
                        // update the value in the data map
                        data['studentId'] = value;
                      },
                    ),
                    SizedBox(height: 10), // Add spacing between the widgets
                    ElevatedButton(
                      onPressed: () async {
                        // updateProfile('27672024', 'cliff', 'dgs@gaj.com', 'css', '2004', 'sasa', '27-01-2010', 'banku', 'shazam', 'Magnifi123');
                        try {
                          // Make the PUT request to update the profile
                          Future<Map<String, dynamic>> futureResult = httpHelper.updateProfile(
                            data['studentId'],
                            data['name'],
                            data['email'],
                            data['major'],
                            data['yearGroup'],
                            data['residenceStatus'],
                            data['dateOfBirth'],
                            data['bestFood'],
                            data['bestMovie'],
                            data['password'],
                          );
                          Map<String, dynamic> result = await futureResult;

                          // Show a success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Profile updated successfully'),
                            ),
                          );

                          // Optionally, you could also update the data map with the new values
                          // if (result != null) {
                          //   data = result;
                          // }

                        } catch (error) {
                          // Show an error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to update profile'),
                            ),
                          );
                        }
                      },
                      child: Text('Update Profile'),
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
