import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import 'pages/pages.dart';

class Routes {
  static Router router = Router();

  static String home = "/";
  static String question = "/question";

  static var homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HotRankList();
  });

  static var questionHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    int id = int.parse(params["id"]?.first);

    if (id <= 0) {
      return Container();
    }
    return QuestionOverviewPage(id: id);
  });

  static void configureRoutes() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(home, handler: homeHandler);
    router.define(question, handler: questionHandler);
  }
}
