import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = '먹VOTE';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            children: [
              SizedBox(height: 150),
              Text(appTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                  )
              ),
              SizedBox(height: 30),
              Text('회원가입',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                  )
              ),
              SizedBox(height: 40),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpResult {
  final int result;
  SignUpResult({this.result});

  factory SignUpResult.fromJson(Map<String, dynamic> json){
    return SignUpResult(
      result: json['result'],
    );
  }
}


// Create a Form widget.
class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class SignUpFormState extends State<SignUpForm> {
  //Future<UserResult> _futureUserResult;

  String id = '';
  String pw = '';

  Future<SignUpResult> registerUser(String id, String pw) async {
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

    if(response.statusCode == 200){
      print('server return');
      print(jsonDecode(response.body));
      return SignUpResult.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response, // then throw an exception.
      throw Exception('Failed to create user.');
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
            validator: (val) => val.length < 3 ? 'ID is too short.' : null,
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
            validator: (val) => val.length < 3 ? 'PW is too short.' : null,
            onChanged: (val) {
              setState(() {
                pw = val;
              });
              print('pw : $pw');
            },
              obscureText: true,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: OutlineButton(
                  onPressed: () {
                    ///jason 확인
                    setState(() {
                      print('$id + $pw');
                      registerUser(id, pw).then((value) => value.result == -1
                          ? _showMyDialog()
                          : _successSignUpDialog()
                      );
                    });
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
                    'FAIL to sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
          titlePadding: const EdgeInsets.all(0),
          content:
          Text('Please use different ID or PW'),
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

  Future<void> _successSignUpDialog() async {
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
                    'Success to sign up!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
          titlePadding: const EdgeInsets.all(0),
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
              onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => LoginPage(),
        ),
        ),
              child: Text(
                'GO to LOGIN',
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

