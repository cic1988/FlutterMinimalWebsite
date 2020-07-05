import 'package:flutter/material.dart';

import 'package:minimal/model/hotrankitem.dart';
import 'package:minimal/api/zhihu.dart';
import 'package:minimal/components/components.dart';

class QuestionOverviewPage extends StatelessWidget {
  static const routeName = '/question';

  final int id;

  QuestionOverviewPage({this.id});

  Widget buildQuestionCard() {
    return FutureBuilder<QuestionItem>(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            {
              List<AnswerItem> answers = snapshot.data.answers;

              return SingleChildScrollView(
                  child: Column(children: [
                QuestionBlock(
                  question: snapshot.data,
                ),
                AnswerBlock(answer: answers[0]),
                AnswerBlock(answer: answers[1]),
                AnswerBlock(answer: answers[2]),
                AnswerBlock(answer: answers[3]),
                AnswerBlock(answer: answers[4]),
              ]));
            }
        }
      },
      future: API.question(this.id),
    );
  }

  Widget buildCentralWidget() {
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Column(children: <Widget>[
              MenuBar(),
              SizedBox(height: 20),
              buildQuestionCard(),
              Footer()
            ])));
  }

  @override
  Widget build(BuildContext context) {
    if (id <= 0) {
      return Container();
    }
    return Scaffold(body: buildCentralWidget(), backgroundColor: Colors.white);
  }
}
