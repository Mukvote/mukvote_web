//Fetch data from internet
import 'package:http/http.dart' as http;
import 'class/user.dart';
import 'dart:convert';

class ServerData {

  //sending data to server
  Future<UserResult> registerUser(String id, String pw) async {
    final response = await http.post(
      Uri.http('127.0.0.1:5000', 'user_register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_name": id,
        'login_token': pw,
      }),
    );

    print('id: $id');

    if(response.statusCode == 200){
      print('server return');
      print(jsonDecode(response.body));
      return UserResult.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response, // then throw an exception.
      throw Exception('Failed to create success.');
    }
  }


  // Future<http.Response> createAlbum(String id, String pw) {
  //   return http.post(
  //     Uri.parse('3.142.77.126:5000/user_register'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'user_name': id,
  //       'login_token' : pw,
  //     }),
  //   );
  // }


}