import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mukvote_web/log_sign_in/login.dart';
import 'package:mukvote_web/log_sign_in/signup.dart';
import 'package:mukvote_web/result_page.dart';
import 'package:mukvote_web/vote_page.dart';



class AppRoutes {
  // static final routeNotFoundHandler = Handler(
  //     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  //       debugPrint("Route not found.");
  //
  //       return RouteNotFoundPage();
  //     });

  static final rootRoute = AppRoute(
    '/',
    Handler(
      handlerFunc: (context, parameters) => SignUpPage(),
    ),
  );

  static final contactListRoute = AppRoute(
    '/login',
    Handler(
      handlerFunc: (context, parameters) => LoginPage(),
    ),
  );

  static final contactDetailRoute = AppRoute(
    '/poll/:id',
    Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          final String contactId = params["id"][0];
          print('아니' );
          print(contactId);

          return VotePage(id: contactId);
        }),
  );

  /// Primitive function to get one param detail route (i.e. id).
  static String getDetailRoute(String parentRoute, String id) {
    return "poll/$id";
  }

  static final List<AppRoute> routes = [
    rootRoute,
    contactListRoute,
    contactDetailRoute,
  ];
}