import 'package:flutter/material.dart';

class SignUpFailPage extends StatelessWidget {
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
              SizedBox(height: 50),
              Icon(Icons.check, size: 20, color: Colors.deepPurpleAccent,),
              Text('회원가입 실패...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                  )
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '다시 회원가입 하',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 15, 50, 15)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepPurpleAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          //side: BorderSide(color: Colors.red)
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}