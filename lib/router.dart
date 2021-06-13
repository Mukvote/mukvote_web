import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mukvote_web/log_sign_in/login.dart';
import 'package:mukvote_web/result_page.dart';
import 'package:mukvote_web/vote_page.dart';

import 'class/item.dart';
import 'log_sign_in/signup.dart';

class MyFluroRouter {
  static FluroRouter router = FluroRouter();

  static Handler _LoginPageHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginPage());
  // static Handler _HomePageHandler = Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
  //         VotePage());
  static Handler _MyClassHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SignUpPage());
  static Handler _MyClassDetailHandler =
  Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    print(context.settings.arguments);
    final args = context.settings.arguments;
    print(args);
    var uri = Uri.parse(context.settings.name);
    print(uri);
    if (uri.pathSegments.length == 2 &&
        uri.pathSegments.first == 'poll') {
      var id = uri.pathSegments[1];
      print(id);
      return VotePage(id: id);
    }else{
      return LoginPage();
    }
  });


  static void setupRouter() {

    router.define('/login',
        handler: _LoginPageHandler, transitionType: TransitionType.fadeIn);
    router.define("/poll",
        handler: _MyClassDetailHandler, transitionType: TransitionType.fadeIn);
    router.define('/signup',
        handler: _MyClassHandler, transitionType: TransitionType.fadeIn);

  }
}