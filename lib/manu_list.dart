import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mukvote_web/search_page.dart';

class MenuListPage extends StatefulWidget {
  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchPage(),
                  ),
                ).then((value) => Navigator.pop(context));
              },
            ),
          ],
          title: Text('먹VOTE',
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          //backgroundColor: Color(0xff5808e5),
          bottom: TabBar(
            labelColor: Colors.deepPurpleAccent,
            indicatorColor: Colors.deepPurpleAccent,
            tabs: [
              Tab(text: '양덕'),
              Tab(text: '법원'),
              Tab(text: '영일대'),
              Tab(text: '배달'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Yangdeok
            FutureBuilder<List<Restaurant>>(
              future: fetchRestaurants(http.Client(), '양덕'),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListView(children: [ListkBuilder(snapshot.data)])
                    : Center(child: CircularProgressIndicator());
              },
            ),
            //beobwon
            FutureBuilder<List<Restaurant>>(
              future: fetchRestaurants(http.Client(), '법원'),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListView(children: [ListkBuilder(snapshot.data)])
                    : Center(child: CircularProgressIndicator());
              },
            ),
            //yeongildae
            FutureBuilder<List<Restaurant>>(
              future: fetchRestaurants(http.Client(), '영일대'),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListView(children: [ListkBuilder(snapshot.data)])
                    : Center(child: CircularProgressIndicator());
              },
            ),
            //order
            FutureBuilder<List<Restaurant>>(
              future: fetchRestaurants(http.Client(), '배달'),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListView(children: [ListkBuilder(snapshot.data)])
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
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
      separatorBuilder: (BuildContext context, int index){
        return Container(
            height: 20,
            child: Divider(height: 5));},
      itemBuilder: (BuildContext context, int index) {
        // return ShowRestaurant(restaurantItems[index]);
        return ListTile(
          title: Text(restaurantItems[index].name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
          trailing: Text(restaurantItems[index].category, style: TextStyle(fontSize: 16, color: Colors.deepPurpleAccent,),
        ));
      },
    );
  }
}

// For connection server
// A function that converts a response body into a List<Photo>.
List<Restaurant> parseRestaurants(String responseBody) {
  var restaurantJson = jsonDecode(responseBody)['restaurant_data'] as List;
  List restaurants = restaurantJson.map((tagJson) => Restaurant.fromJson(tagJson)).toList();
  return restaurants;
}


Future<List<Restaurant>> fetchRestaurants(http.Client client, String place) async {
  final response = await client
      // .get(Uri.parse('http://127.0.0.1:5000/poll/' + '36'));
  .get(Uri.parse('http://127.0.0.1:5000/restaurant/' + place));
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
