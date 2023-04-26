import 'package:http/http.dart' as http;
import 'dart:convert';
class HTTPHelper{

//--- Fetching all items
Future<List<Map>> fetchItems() async{
  List<Map> items = [];


  //Get the data from the API
  http.Response response =await http.get(Uri.parse('http://127.0.0.1:200/posts'));

  if(response.statusCode==200)
    {
      //get the data from the response
      String jsonString=response.body;
      //convert to List<Map>
      List data = jsonDecode(jsonString);
      items = data.cast<Map>();
    }
  return items;
}



  // Create Post
  Future createPost(String title, String content, String email) async {
    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:200/posts/"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'content': content,
          'email': email,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }


  // Create Profile
  Future<bool> createProfile(String studentId, String name, String email, String dateOfBirth, String yearGroup, String major, String residenceStatus, String bestFood, String bestMovie, String password) async {
    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:200/profiles/"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "studentId": studentId,
          "name": name,
          "email": email,
          "dateOfBirth": dateOfBirth,
          "yearGroup": yearGroup,
          "major": major,
          "residenceStatus": residenceStatus,
          "bestFood": bestFood,
          "bestMovie": bestMovie,
          "password": password,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // print(e.toString());
      return false;
    }
  }



  //
  // add ittem
  // Future<bool> addItem(Map data) async {
  //   bool status = false;
  //
  //   //Add the item to the database, call the API
  //   http.Response response = await http.post(
  //     Uri.parse('http://127.0.0.1:200/posts'),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-type': 'application/json',
  //     },
  //   );
  //
  //   if (response.statusCode == 201) {
  //     status = response.body.isNotEmpty;
  //   }
  //
  //   return status;
  // }
//--- Update an item
  Future<Map<String, dynamic>> updateProfile(String studentId, String name, String email, String major, String yearGroup, String residenceStatus, String dateOfBirth, String bestFood, String bestMovie, String password) async {
    final url = Uri.parse('http://127.0.0.1:200/profiles?studentId=27672024');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email': email,
        "bestFood": bestFood,
        "bestMovie": bestMovie,
        "dateOfBirth": dateOfBirth,
        "major": major,
        "password": password,
        "residenceStatus": residenceStatus,
        "studentId": studentId,
        "yearGroup": yearGroup,
      }),
    );
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      print(response.statusCode);
      throw Exception('Failed to update profile');
    }
  }


//-- Update an item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    //Update the item, call the API
    http.Response response = await http
        .put(
        Uri.parse('http://127.0.0.1:200/profiles?studentId=27672024'),
        body: jsonEncode(data),
        headers: {
          'Content-type':'application/json'
        }
    );

    if(response.statusCode==200)
    {
      status=response.body.isNotEmpty;
    }

    return status;
  }


  //-- Update an item
  Future<bool> editItem(Map data, String itemId) async {
    bool status = false;

    //Update the item, call the API
    http.Response response = await http
        .put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
        body: jsonEncode(data),
        headers: {
          'Content-type':'application/json'
        }
    );

    if(response.statusCode==200)
    {
      status=response.body.isNotEmpty;
    }

    return status;
  }


//--- Delete an item
  Future<bool> deleteItem(String itemId) async{
    bool status = false;


    //Delete the item from the API
    http.Response response =await http.delete(Uri.parse('http://127.0.0.1:200/posts$itemId'));

    if(response.statusCode==200){
      status=true;
    }

    return status;
  }

}