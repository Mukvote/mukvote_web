import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mukvote_web/log_sign_in/login.dart';
import 'class/item.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class ResultTile extends StatefulWidget{
  ResultTile(this._restaurant, this.idx);
  final Result _restaurant;
  final int idx;

  @override
  _ResultTileState createState() => _ResultTileState();
}

class _ResultTileState extends State<ResultTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text((widget.idx + 1).toString(), style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black45),)),
      title: Text(widget._restaurant.name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black45),),
      trailing: Text('${(widget._restaurant.result*100).round()}%', style: TextStyle(fontSize: 16, color: Colors.black45),),
    );
  }
}

class TopResultTile extends StatefulWidget{
  TopResultTile(this._item, this.idx);
  final Result _item;
  final int idx;
  String img = 'assets/1_dotori.png';

  void bedge(int n){
    switch(n) {
      case 0: {
        img = 'assets/1_dotori.png';
      }
      break;

      case 1: {
        img = 'assets/2_dotori.png';
      }
      break;

      case 2: {
        img = 'assets/3_dotori.png';
      }
      break;
    }
  }

  @override
  _TopResultTileState createState() => _TopResultTileState();
}

class _TopResultTileState extends State<TopResultTile> {
  @override
  Widget build(BuildContext context) {
    widget.bedge(widget.idx);

    return Container(
      // decoration: new BoxDecoration (
      //     color: Color(0XFF7C4DFF)
      // ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Image.asset(
            widget.img,
            width: 50,
            height: widget.idx == 0 ? 100 : 40 ,
        ),
        title: Text(widget._item.name, style: TextStyle(fontSize: widget.idx == 0 ? 20 : 18,fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
        trailing: Text('${(widget._item.result*100).round()}%', style: TextStyle(fontSize: widget.idx == 0 ? 20 : 18, color: Colors.deepPurpleAccent),),
      ),
    );
  }
}

class ResultPage extends StatefulWidget{
  ResultPage(this.id);
  final String id;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
                    '방장이 아니네요ㅠ_ㅠ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
          titlePadding: const EdgeInsets.all(0),
          content:
          Text('방장만 투표 종료를 할 수 있습니다^^'),
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

  Future<DeleteResult> deleteAlbum(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://127.0.0.1:5000/poll/$id/' + LoginPage.user_id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      LoginPage.user_id =  DeleteResult.fromJson(jsonDecode(response.body)).result;
      return DeleteResult.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print('not delete in');
      throw Exception('Failed to delete.');
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
        body:SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Image.asset(
                    'assets/투표완료.png',
                  width: 180,
                ),
                SizedBox(height: 40,),
                FutureBuilder<List<Result>>(
                  future: fetchResult(http.Client(), widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);

                    return snapshot.hasData
                        ? ResultBuilder(snapshot.data)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    Container(
                      height: 40.0,
                      width: 120.0,
                      child: FittedBox(
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            deleteAlbum(widget.id).then((value) => value.result == 0
                                ? _showMyDialog()
                                : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            ));
                          },
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.deepPurpleAccent,
                          icon: Icon(Icons.clear, size: 18,),
                          label: Text("투표종료", style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ResultBuilder extends StatelessWidget {
  ResultBuilder(this._restaurant);
  final List<Result> _restaurant;



  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Text(_restaurant[0].participantNum.toString() + '명 참여중',style: TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,

          ),),
          ListView.separated(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          // itemCount: items.length + 1,
          itemCount: _restaurant.length,
          separatorBuilder: (BuildContext context, int index){
            return Container(
                height: 20,
                child: Divider(height: 5));

            },
          itemBuilder: (BuildContext context, int index) {
            return index > 2 ? ResultTile(_restaurant[index], index) : TopResultTile(_restaurant[index], index);
          },
    ),
        ],
      );
  }
}


// For connection server
// A function that converts a response body into a List<Photo>.
List<Result> parseRestaurants(String responseBody) {
  var restaurantJson = jsonDecode(responseBody)['poll_data'] as List;
  List restaurants = restaurantJson.map((tagJson) => Result.fromJson(tagJson)).toList();
  return restaurants;
}


Future<List<Result>> fetchResult(http.Client client, String id) async {
  final response = await client
      .get(Uri.parse('http://127.0.0.1:5000/vote/result/' + id));
  // Use the compute function to run parsePhotos in a separate isolate.
  return parseRestaurants(response.body);
}


class Result {
  int participantNum;
  double result;
  // final String category;
  String name;

  Result({
    this.participantNum,
    this.result,
    // this.category,
    this.name,
  });

  factory Result.fromJson(dynamic json) {
    return Result(
      participantNum: json['number_of_participant'] as int,
      result: json['result'] as double,
      // category: json['restaurant_category'] as String,
      name: json['restaurant_name'] as String,
    );
  }
}


class DeleteResult {
  final int result;

  DeleteResult({this.result});

  factory DeleteResult.fromJson(Map<String, dynamic> json) {
    return DeleteResult(
      result: json['delete_data'],
    );
  }
}

