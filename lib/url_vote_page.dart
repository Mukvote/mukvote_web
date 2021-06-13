import 'package:flutter/material.dart';
import 'app_router.dart';
import 'log_sign_in/AppRoutes.dart';
import 'vote_page.dart';
import 'package:flutter/services.dart';

class UrlVote extends StatelessWidget {
  UrlVote(this.url, this.id);
  final String url;
  final int id;

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
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFFBDA6FF),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      //child: Text('http://127.0.0.1:8989/poll/' + id.toString()),
                      child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Room Key:  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(id.toString(),
                            style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )),

                  ),
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //clip board
                          Clipboard.setData(new ClipboardData(text: id.toString()));
                         // Clipboard.setData(new ClipboardData(text: 'http://127.0.0.1:8989/#/poll/' + id.toString()));
                        },
                        child: Text(
                          'key 복사',
                        ),
                        style: ButtonStyle(
                          //padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 15, 50, 15)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurpleAccent),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                ))),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          AppRouter.router.navigateTo(
                            context,
                            AppRoutes.getDetailRoute(
                              AppRoutes.contactDetailRoute.route,
                              id.toString(),
                            ),
                          );
                          // Navigator.push( context, MaterialPageRoute(
                          //   builder: (context) => VotePage(id : id.toString()),
                          // ),
                          // );
                          // Navigator.pushNamed(
                          //   context,
                          //   url,
                          // );
                        },
                        child: Text(
                          ' 열기',
                        ),
                        style: ButtonStyle(
                          //padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 15, 50, 15)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurpleAccent),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white),
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
