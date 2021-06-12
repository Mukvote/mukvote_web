import 'package:flutter/material.dart';
import 'log_sign_in/login.dart';
import 'make_vote_page.dart';
import 'vote_page.dart';

void main() => runApp(MuckVote());

class MuckVote extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '먹VOTE',
      // home: VotePage(),
      initialRoute: '/login',

      onGenerateRoute: _getRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/create': (context) => MakeVote(),
        '/poll': (context) => VotePage(),
      },
      // TODO: Add a theme (103)
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {



      // Handle '/details/:id'
      var uri = Uri.parse(settings.name);
      print('uri');
      print(uri);
      if (uri.pathSegments.length == 2 &&
          uri.pathSegments.first == 'poll') {
        var id = uri.pathSegments[1];
        return MaterialPageRoute(builder: (context) => VotePage(id: id));
      }



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