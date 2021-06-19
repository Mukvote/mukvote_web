import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mukvote_web/log_sign_in/AppRoutes.dart';
import 'package:mukvote_web/log_sign_in/signup.dart';
import 'package:mukvote_web/router.dart';
import 'app_router.dart';
import 'log_sign_in/login.dart';
import 'make_vote_page.dart';
import 'vote_page.dart';

void main() {
  runApp(MuckVote());
}

class MuckVote extends StatefulWidget {
  @override
  _MuckVote createState() => _MuckVote();
}
class _MuckVote extends State<MuckVote> {
  @override
  void initState() {
    super.initState();
    AppRouter appRouter = AppRouter(
      routes: AppRoutes.routes,
      // notFoundHandler: AppRoutes.routeNotFoundHandler,
    );

    appRouter.setupRoutes();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '먹VOTE',
      // home: VotePage(),
      onGenerateRoute: AppRouter.router.generator,
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: _getRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/create': (context) => MakeVote(),
        '/poll': (context) => VotePage(),
      },
      // TODO: Add a theme (103)

    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
      // Handle '/poll/:id'
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