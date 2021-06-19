import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchResultPage extends StatefulWidget {
  final String keyword;

  SearchResultPage({Key key, this.keyword}) : super(key: key);

  @override
  _SearchResultPage createState() => _SearchResultPage(keyword);

}

class _SearchResultPage extends State<SearchResultPage> {
  String keyword;

  _SearchResultPage(this.keyword);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.deepPurpleAccent, // add custom icons also
          ),
        ),
       title: Text('검색결과 ' + keyword,
            style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,),
      body:
      FutureBuilder<List<Restaurant>>(
          future: fetchRestaurants(http.Client(), keyword),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ListView(children: [ListkBuilder(snapshot.data)])
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ListkBuilder extends StatelessWidget {
  ListkBuilder(this.restaurantItems);

  var restaurantItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      // itemCount: items.length + 1,
      itemCount: restaurantItems.length,
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 20, child: Divider(height: 5));
      },
      itemBuilder: (BuildContext context, int index) {
        // return ShowRestaurant(restaurantItems[index]);
        return ListTile(
            title: Text(
              restaurantItems[index].name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent),
            ),
            trailing: Text(
              restaurantItems[index].category,
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurpleAccent,
              ),
            ));
      },
    );
  }
}

// For connection server
// A function that converts a response body into a List<Photo>.
List<Restaurant> parseRestaurants(String responseBody) {
  var restaurantJson = jsonDecode(responseBody)['search_result'] as List;
  List restaurants =
      restaurantJson.map((tagJson) => Restaurant.fromJson(tagJson)).toList();
  return restaurants;
}

Future<List<Restaurant>> fetchRestaurants(
    http.Client client, String keyword) async {
  final response =
      await client.get(Uri.parse('http://127.0.0.1:5000/restaurant/search/' + keyword));
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

  Restaurant(
      {this.orderCount,
      this.id,
      this.category,
      this.name,
      this.place,
      this.priority});

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
