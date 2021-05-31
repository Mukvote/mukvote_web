import 'package:flutter/material.dart';
//import 'package:db_muckvote/log_sign_in/login.dart';

//class
import '../class/user.dart';

//server
import '../server.dart';
import 'signup_succ.dart';

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
  Future<UserResult> _futureUserResult;

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
                      _futureUserResult = ServerData().registerUser(id, pw);
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

  FutureBuilder<UserResult> buildFutureBuilder() {
    print("??");
    return
      FutureBuilder<UserResult>(
      future: _futureUserResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String result = snapshot.data.result;
          print("result" + result);
          if(result == 'success') return SignUpSuccessPage();
          else return SignUpPage();
          // Navigator.push( context, MaterialPageRoute(
          //   builder: (context) => LoginPage(),
          // ));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return CircularProgressIndicator();
      },
    );
  }

}

