import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mukvote_web/home.dart';
import '../make_vote_page.dart';
import 'signup.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  static int user_id;
  static Route<LoginPage> route() =>
      MaterialPageRoute(builder: (context) => LoginPage());

  @override
  Widget build(BuildContext context) {
    final appTitle = '먹VOTE';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(appTitle,
        //       style: TextStyle(
        //         color: Colors.deepPurpleAccent,
        //         fontWeight: FontWeight.bold,
        //       )
        //   ),
        //   backgroundColor: Colors.white,
        // ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            children: [
              SizedBox(height: 80),
              Text(appTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
              Image.asset(
                'assets/login.png',
                height: 150,
              ),
              SizedBox(height: 80),
              MyCustomForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String id = '';
  String pw = '';

  Future<LoginResult> loginTry() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/user_login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_name': id,
        'login_token': pw,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      LoginPage.user_id =  LoginResult.fromJson(jsonDecode(response.body)).id;
      return LoginResult.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print('not login in');
      throw Exception('Failed to login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ID',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (val) {
              setState(() {
                id = val;
              });
              print('id : $id');
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'PW',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            obscureText: true,
            onChanged: (val) {
              setState(() {
                pw = val;
              });
              print('pw : $pw');
            },
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: OutlineButton(
                  onPressed: () {
                    ///sign up page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    'sign up',
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: OutlineButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.

                    // loginTry().then((value) => value.id < 0
                    //     ? _showMyDialog()
                    //     : Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => MakeVote(),
                    //         ),
                    //       ));

                    loginTry().then((value) => value.id < 0
                        ? _showMyDialog()
                        : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ));

                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              height: 80,
              color: Colors.deepPurpleAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FAIL LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
          titlePadding: const EdgeInsets.all(0),
          content:
          Text('Check Your ID or PW'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                shadowColor: Colors.grey,
                primary: Colors.deepPurpleAccent,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ), // background
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'CLOSE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LoginResult {
  final int id;

  LoginResult({this.id});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      id: json['result'],
    );
  }
}
