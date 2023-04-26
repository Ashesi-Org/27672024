import 'package:flutter/material.dart';
import 'package:webtech_flutter_app/authentication/createpost.dart';

import '../mainscreens/HTTPhelper.dart';

class PostsList extends StatelessWidget {
  PostsList({Key? key}) : super(key: key);

  Future<List<Map>> _futurePosts = HTTPHelper().fetchItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreatePostScreen()));

        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Map>>(
        future: _futurePosts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check for errors
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }
          //Has data arrived
          if (snapshot.hasData) {
            List<Map> posts = snapshot.data;

            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Map thisItem = posts[index];
                  return ListTile(
                    title: Text('${thisItem['title']} by ${thisItem['email']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${thisItem['content']}'),
                        SizedBox(height: 5.0),
                        Text(
                          '${thisItem['date_created']}', // Replace with the time of the post
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );

                });
          }

          //Display a loader
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}