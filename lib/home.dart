import 'package:flutter/material.dart';
import 'package:mukvote_web/manu_list.dart';

import 'check_vote.dart';
import 'make_vote_page.dart';
import 'vote_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('먹VOTE',
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFD6C2FF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                              '새 투표방',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent
                              ),
                        ),
                        SizedBox(height: 10),
                        Image.asset(
                          'assets/new_room.png',
                          height: 120,
                        ),
                        SizedBox(height: 10),

                        ///make new vote
                        ElevatedButton(
                          onPressed: () {
                              print('new vote');
                              Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MakeVote(),
                                          ));
                          },
                          child: Text(
                            '만들기',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurpleAccent[100]),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),

                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFD6C2FF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text(
                          '만들어진 투표방',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent
                          ),
                        ),
                        SizedBox(height: 20),
                        Image.asset(
                          'assets/join_room.png',
                          height: 130,
                        ),
                        SizedBox(height: 10),

                        ///join vote
                        TextFormField(
                          controller: _roomController,
                          decoration: InputDecoration(
                            hintText: 'Room Key',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your message to continue';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            print('join vote');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckVotePage(id : _roomController.text),
                                ));
                          },
                          child: Text(
                            '들어가기',
                            style: TextStyle(
                              fontSize: 15,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurpleAccent[100]),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ),


                SizedBox(height: 30),

                InkWell(
                  onTap: (){
                    print('go manu page list');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuListPage(),
                        ));
                  },
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.deepPurpleAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '음식 리스트 보기',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          Icon(
                              Icons.arrow_forward_ios,
                            color: Colors.white,
                          )

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}

