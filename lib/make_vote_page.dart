import 'dart:convert';

import 'package:flutter/material.dart';
import 'log_sign_in/login.dart';
import 'url_vote_page.dart';
import 'package:http/http.dart' as http;

class MakeVote extends StatelessWidget {

  //send poll data
  /*
    data format example
      {
          "owner":1,
          "place":"양덕",
          "categories": ["양식", "중식", "카페"]
      }
   */
  Future<Response> createVote() async {
    List<String> checkCategories = [];
    for(int i=0; i<categories.length; i++){
      if(check2[i]){
        checkCategories.add(categories[i]);
      }
    }
    print(checkCategories);
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/poll'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'owner' : LoginPage.user_id,
        'place': options[_value],
        'categories' : checkCategories
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return Response.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }


  @override
  Widget build(BuildContext context) {
    final appTitle = '먹VOTE';

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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text('장소',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 10),
                      ChoicePlace(),
                      SizedBox(height: 40),
                      Text('카테고리',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 10),
                      Filter(),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    createVote().then((value) => Navigator.push( context, MaterialPageRoute(
                      builder: (context) => UrlVote(value.url, value.id),
                    ),
                    ))
                    ;
                  },
                  child: Text(
                    '투표 만들기',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 15, 50, 15)),
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
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> options = ['양덕', '법원', '영일대', '배달'];
List<String> categories = ['중식', '일식', '한식', '양식'];
int _value;
List<bool> check2 = [false, false, false, false];

class ChoicePlace extends StatefulWidget {
  @override
  _ChoicePlaceState createState() => _ChoicePlaceState();
}

class _ChoicePlaceState extends State<ChoicePlace> {


  int index = 1;


  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate( options.length, (int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(options[index]),
              labelStyle: TextStyle(color: _value == index ? Colors.white : Colors.black),
              selected: _value == index,
              selectedColor: Colors.deepPurpleAccent,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? index : null;
                });
              },
            ),
          );
        },
      ).toList(),
    );
  }
}

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<bool> check = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///palce
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

        SizedBox(height: 35),

        ///categories
        Wrap(
          children: [
            FilterChip(
              label: Text('중식'),
              selected: check2[0],
              showCheckmark: false,
              onSelected: (bool value) {
                setState(() {
                  check2[0] = !check2[0];
                });
              },
              labelStyle: TextStyle(
                color: check2[0] ? Colors.white : Colors.black,
              ),
              selectedColor: Colors.deepPurpleAccent,
              avatar: check2[0] ? Icon(Icons.check, color: Colors.white, size: 20,) : null,
            ),
            SizedBox(width: 12),
            FilterChip(
              label: Text('일식'),
              showCheckmark: false,
              selected: check2[1],
              onSelected: (bool value) {
                setState(() {
                  check2[1] = !check2[1];
                });
              },
              selectedColor: Colors.deepPurpleAccent,
              labelStyle: TextStyle(
                color: check2[1] ? Colors.white : Colors.black,
              ),
              avatar: check2[1] ? Icon(Icons.check, color: Colors.white, size: 20,) : null,
            ),
            SizedBox(width: 12),
            FilterChip(
              label: Text('한식'),
              showCheckmark: false,
              selected: check2[2],
              onSelected: (bool value) {
                setState(() {
                  check2[2] = !check2[2];
                });
              },
              selectedColor: Colors.deepPurpleAccent,
              labelStyle: TextStyle(
                color: check2[2] ? Colors.white : Colors.black,
              ),
              avatar: check2[2] ? Icon(Icons.check, color: Colors.white, size: 20,) : null,
            ),
            SizedBox(width: 12),
            FilterChip(
              label: Text('양식'),
              showCheckmark: false,
              selected: check2[3],
              onSelected: (bool value) {
                setState(() {
                  setState(() {
                    check2[3] = !check2[3];
                  });
                });
                },
              selectedColor: Colors.deepPurpleAccent,
              labelStyle: TextStyle(
                color: check2[3] ? Colors.white : Colors.black,
              ),
              avatar: check2[3] ? Icon(Icons.check, color: Colors.white, size: 20,) : null,
            ),
            SizedBox(width: 12),
          ],
        ),
      ],
    )
    ]
    );
  }
}

class Response {
  final int id;
  final String url;

  Response({this.id, this.url});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      id: json['poll_id'],
      url: json['shared_url'],
    );
  }
}
