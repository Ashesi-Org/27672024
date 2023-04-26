import 'package:flutter/material.dart';

import '../mainscreens/HTTPhelper.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String postTitle = "";
  String postContent = "";
  HTTPHelper  httpHelper = HTTPHelper();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final studentIdController = TextEditingController();
  final postIdController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFab3c43),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Create Post'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      // emailfield
                      TextField(
                        controller: emailController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.title, color: Color(0xffab3c43)),
                        ),
                      ),

                      const SizedBox(height: 20,),
                      // Post title text field
                      TextField(
                        controller: titleController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Post Title",
                          prefixIcon: Icon(Icons.title, color: Color(0xffab3c43)),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // Post content text field
                      TextField(
                        controller: contentController,
                        maxLines: 10,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Post Content",
                          prefixIcon: Icon(Icons.edit, color: Color(0xffab3c43)),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      // Submit button
                      ElevatedButton(
                        onPressed: () async {
                          bool response =  await httpHelper.createPost(titleController.text, contentController.text, emailController.text);
                          if (response) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text('Post added')));
                          }
                          else
                          {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text('Failed to add the post')));
                          }
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
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
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
