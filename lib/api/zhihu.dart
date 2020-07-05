import 'package:minimal/model/hotrankitem.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  static Future<List<RankItem>> topics() async {
    String url = DotEnv().env['ZHIHU_URL_API'];
    List<RankItem> topics = [];

    final header = {'content-type': 'application/json; charset=UTF-8'};
    final res = await http.get(url + '/topics', headers: header);

    if (res.statusCode == 200) {
      final result = json.decode(res.body);

      for (int i = 0; i < result.length; i++) {
        try {
          RankItem item = RankItem.fromJson(result[i]);
          item.rank = (i + 1).toString();
          topics.add(item);
        } catch (e) {
          print('Something unknown: $i went wrong');
        }
      }
    }
    return topics;
  }

  static Future<QuestionItem> question(int id) async {
    String url = DotEnv().env['ZHIHU_URL_API'];

    final header = {'content-type': 'application/json; charset=UTF-8'};
    final res =
        await http.get(url + '/question/' + id.toString(), headers: header);

    QuestionItem item;
    if (res.statusCode == 200) {
      final result = json.decode(res.body);
      try {
        item = QuestionItem.fromJson(result);
      } catch (e) {
        print('Something unknown went wrong');
      }
    }
    return item;
  }
}
