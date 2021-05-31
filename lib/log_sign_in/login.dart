import 'package:flutter/material.dart';
import '../make_vote_page.dart';
import 'signup.dart';

//class
//import '../class/user.dart';

class LoginPage extends StatelessWidget {
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
              SizedBox(height: 150),
              Text(appTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 100),
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
                    // todo: 로그인기 id, pw 보내고 확인하기

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MakeVote(),
                      ),
                    );
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
}
