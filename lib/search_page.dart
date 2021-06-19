import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mukvote_web/search_result_page.dart';

class SearchPage extends StatefulWidget {
  static String tag = 'contactlist-page';

  @override  State<StatefulWidget> createState() {
    return new _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  TextEditingController searchController = new TextEditingController();
  String filter;

  @override  initState() {
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override  Widget build(BuildContext context) {
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
          // title: Text('먹VOTE',
          //     style: TextStyle(
          //       color: Colors.deepPurpleAccent,
          //       fontWeight: FontWeight.bold,
          //     )),
          backgroundColor: Colors.white,),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            children: [
              SizedBox(height: 80),
              Text('음식점 찾기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
              Image.asset(
                'assets/검색.png',
                height: 150,
              ),
              SizedBox(height: 40),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration:

                          InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              new BorderRadius.circular(32.0),
                              borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius:
                              new BorderRadius.circular(32.0),
                              borderSide: new BorderSide(color: Colors.deepPurpleAccent),
                            ),
                            // prefixIcon: Icon(Icons.search),
                          ),
                        )),
                  ])),
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
                          Navigator.push( context, MaterialPageRoute(
                              builder: (context) => SearchResultPage(keyword: searchController.text)));

                        },
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.deepPurpleAccent,
                        icon: Icon(Icons.search, size: 18,),
                        label: Text("검색하기", style: TextStyle(
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
        );
  }
}

