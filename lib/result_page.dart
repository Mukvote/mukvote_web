import 'dart:convert';

import 'package:flutter/material.dart';
import 'class/item.dart';
import 'package:http/http.dart' as http;

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
      trailing: Text('${widget._restaurant.result}', style: TextStyle(fontSize: 16, color: Colors.black45),),
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
        trailing: Text('${widget._item.result}', style: TextStyle(fontSize: widget.idx == 0 ? 20 : 18, color: Colors.deepPurpleAccent),),
      ),
    );
  }
}

class ResultPage extends StatelessWidget{
  ResultPage(this.id);
  final String id;

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
                  future: fetchResult(http.Client(), id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);

                    return snapshot.hasData
                        ? ResultBuilder(snapshot.data)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
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
    return ListView.separated(
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

