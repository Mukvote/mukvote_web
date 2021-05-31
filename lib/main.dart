import 'package:flutter/material.dart';
import 'log_sign_in/login.dart';
import 'make_vote.dart';
import 'vote.dart';

void main() => runApp(MuckVote());

class MuckVote extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '먹VOTE',
      home: VotePage(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      routes: {
        '/create': (context) => MakeVote(),
        '/poll': (context) => VotePage(),
      },
      // TODO: Add a theme (103)
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}