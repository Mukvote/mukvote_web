import 'dart:convert';

import 'package:flutter/material.dart';
import 'log_sign_in/login.dart';
import 'result_page.dart';
import 'class/item.dart';
import 'package:http/http.dart' as http;


class VotePage extends StatefulWidget{
  final String id;

  VotePage({Key key, this.id}) : super(key: key);

  @override
  _VotePageState createState() => _VotePageState(id);
}

class _VotePageState extends State<VotePage> {
  String id;

  _VotePageState(this.id);

  @override
  Widget build(BuildContext context) {
    // final appTitle = '먹VOTE';
    final appTitle = id;

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
        body: LoginPage.user_id == null ? Navigator.push( context, MaterialPageRoute(
          builder: (context) => LoginPage(),
        )) :
        FutureBuilder<List<Restaurant>>(
          future: fetchRestaurants(http.Client(), id),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? RestaurantList(restaurants: snapshot.data, id: id)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class VoteResult{
  int restarant_id;
  bool restarant_vote;
  VoteResult({this.restarant_id, this.restarant_vote});

  Map toJson() => {
    'restarant_id': restarant_id,
    'restarant_vote': restarant_vote,
  };
}

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;
  final id;
  RestaurantList({Key key, this.restaurants, this.id}) : super(key: key);
  var restaurantItems;
  var resultRestaurant;

  Future sendVoteResult() async {
    resultRestaurant = List<VoteResult>.generate(restaurantItems.length, (index) {
      return VoteResult(
        restarant_vote: restaurantItems[index].checked,
        restarant_id: restaurantItems[index].restaurant.id,
      );
    });
    print(jsonEncode(<String, dynamic>{
      'data' : resultRestaurant,
    }));
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/' + id + "/" + LoginPage.user_id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'data' : resultRestaurant,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print(jsonDecode(response.body));
      // return Response.fromJson(jsonDecode(response.body));
      return "success";
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    restaurantItems = List<Item>.generate(restaurants.length, (index) {
      return Item(
        restaurant: restaurants[index],
        checked: false,
      );
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          RestaurantBuilder(restaurantItems),
          SizedBox(height: 40,),
          ElevatedButton(
            onPressed: () {
              //todo: undo comment
              // sendVoteResult().then((value) => Navigator.push( context, MaterialPageRoute(
              //   builder: (context) => ResultPage(restaurantItems),
              // ))
              // ,
              // );
              Navigator.push( context, MaterialPageRoute(
                    builder: (context) => ResultPage(restaurantItems),
                  ));
            },
            child: Text(
              '투표하기',
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
          SizedBox(height: 100,),
        ],
      ),
    );
  }
}

class RestaurantBuilder extends StatelessWidget {
  RestaurantBuilder(this.restaurantItems);
  var restaurantItems;
  @override
  Widget build(BuildContext context) {


    return ListView.separated(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      // itemCount: items.length + 1,
      itemCount: restaurantItems.length,
      separatorBuilder: (BuildContext context, int index){
        return Container(
          height: 20,
            child: Divider(height: 5));},
      itemBuilder: (BuildContext context, int index) {
        return ShowRestaurant(restaurantItems[index]);
      },
    );
  }
}

class ShowRestaurant extends StatefulWidget{
  ShowRestaurant(this._restaurant);
  final Item _restaurant;

  @override
  _ShowRestaurantState createState() => _ShowRestaurantState();
}

class _ShowRestaurantState extends State<ShowRestaurant> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: (widget._restaurant.checked) ? Icon(Icons.check, color: Colors.deepPurpleAccent,) : Icon(Icons.lens_outlined),
        onPressed: (){
          setState(() {
            widget._restaurant.checked ? widget._restaurant.checked = false : widget._restaurant.checked = true;
            // widget._item.checked ? widget._item.restaurant.priority++ : widget._item.restaurant.priority--;
          });
        },
      ),
      title: Text(widget._restaurant.restaurant.name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: (widget._restaurant.checked) ? Colors.deepPurpleAccent : Colors.black45),),
      trailing: Text('${widget._restaurant.restaurant.place}', style: TextStyle(fontSize: 16, color: (widget._restaurant.checked) ? Colors.deepPurpleAccent : Colors.black45),),
    );
  }
}

// For connection server
// A function that converts a response body into a List<Photo>.
List<Restaurant> parseRestaurants(String responseBody) {
  var restaurantJson = jsonDecode(responseBody)['poll_data'] as List;
  List restaurants = restaurantJson.map((tagJson) => Restaurant.fromJson(tagJson)).toList();
  return restaurants;
}


Future<List<Restaurant>> fetchRestaurants(http.Client client, String id) async {
  final response = await client
      .get(Uri.parse('http://127.0.0.1:5000/poll/' + id));
  // Use the compute function to run parsePhotos in a separate isolate.
  return parseRestaurants(response.body);
}


class Restaurant {
  final int orderCount;
  final int id;
  final String category;
  final String name;
  final String place;
  final int priority;

  Restaurant({
    this.orderCount,
    this.id,
    this.category,
    this.name,
    this.place,
    this.priority
  });

  factory Restaurant.fromJson(dynamic json) {
    return Restaurant(
      orderCount: json['order_count'] as int,
      id: json['restaurant_id'] as int,
      category: json['restaurant_category'] as String,
      name: json['restaurant_name'] as String,
      place: json['restaurant_place'] as String,
      priority: json['restaurant_priority'] as int,
    );
  }
}

