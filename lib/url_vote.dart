import 'package:flutter/material.dart';
import 'vote.dart';

class UrlVote extends StatelessWidget {
  UrlVote(this.url);
  final String url;

  final appTitle = '먹VOTE';

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle,
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
        ),
        body: Padding(
            padding: EdgeInsets.all(25),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text('투표방 생성 완료',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFFBDA6FF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('http://127.0.0.1:5000/' + url),
                  ),
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          '링크 복사',
                          // style: TextStyle(
                          //   fontSize: 18,
                          // ),
                        ),
                        style: ButtonStyle(
                          //padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 15, 50, 15)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.deepPurpleAccent)
                                ))),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push( context, MaterialPageRoute(
                            builder: (context) => VotePage(),
                          ),
                          );
                        },
                        child: Text(
                          '링크 열기',
                        ),
                        style: ButtonStyle(
                          //padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 15, 50, 15)),
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
                ],
              ),
            )),
      ),
    );
  }
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class PollArguments {
  final String id;
  PollArguments(this.id);
}
