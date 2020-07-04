import 'package:minimal/model/hotrankitem.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

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
          topics.add(RankItem.fromJson(result[i]));
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

  static Future<AnswerItem> answer(int id) async {
    final header = {
      'content-type': 'text/html; charset=utf-8',
    };
    final queryParameters = {
      'include': 'voteup_count,comment_count,content',
    };

    final url = Uri.https('www.zhihu.com', '/api/v4/answers/' + id.toString());

    //final res = http.get('https://google.de', headers: header);
    final res =
        await http.get("https://www.zhihu.com/api/v4/answers/" + '1111111');

    AnswerItem item;

    print(res);

    /*if (res.statusCode == 200) {
      final result = json.decode(res.body);
      try {
        item = AnswerItem.fromJsonV1(result);
      } catch (e) {
        print('Something unknown went wrong');
      }
    }*/
    return item;
  }
}
