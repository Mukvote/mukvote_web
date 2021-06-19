import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mukvote_web/log_sign_in/login.dart';
import 'package:mukvote_web/result_page.dart';
import 'package:mukvote_web/vote_page.dart';

class CheckVotePage extends StatefulWidget {
  final String id;

  CheckVotePage({Key key, this.id}) : super(key: key);

  @override
  _CheckVotePageState createState() => _CheckVotePageState(id);
}

class _CheckVotePageState extends State<CheckVotePage> {
  String id;

  _CheckVotePageState(this.id);

  changeRoute(int tf) async {
    await Future.delayed(Duration(seconds: 1), () {
      tf != 0
          ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(id),
          ))
          : Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VotePage(id: id),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<int>(
          future: fetchRestaurants(http.Client(), id),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? (snapshot.data != 0 ? ResultPage(id) : VotePage(id: id))
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

int parseRestaurants(String responseBody) {
  int tf = jsonDecode(responseBody)['check_result'];
  return tf;
}

Future<int> fetchRestaurants(http.Client client, String voidId) async {
  final response = await client.get(Uri.parse('http://127.0.0.1:5000/check/' +
      voidId +
      '/' +
      LoginPage.user_id.toString()));
  return parseRestaurants(response.body);
}

// class CheckResult {
//   final bool tf;
//
//   CheckResult({this.tf});
//
//   factory CheckResult.fromJson(Map<String, dynamic> json) {
//     return CheckResult(
//       tf: json['result'],
//     );
//   }
// }
