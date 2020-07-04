import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:minimal/components/components.dart';
import 'package:minimal/utils/utils.dart';
import 'package:minimal/model/hotrankitem.dart';

class QuestionBlock extends StatelessWidget {
  final QuestionItem question;

  QuestionBlock({this.question});

  @override
  Widget build(BuildContext context) {
    final questionUrl = 'https://www.zhihu.com/question/' + question.id;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      margin: blockMargin,
      child: ResponsiveRowColumn(
        rowColumn: !ResponsiveWrapper.of(context).isSmallerThan(DESKTOP),
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        columnMainAxisSize: MainAxisSize.min,
        rowPadding: EdgeInsets.symmetric(horizontal: 80, vertical: 80),
        columnPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        columnSpacing: 50,
        rowSpacing: 50,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowFit: FlexFit.tight,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(question.questionTitle,
                      style: headlineSecondaryTextStyle,
                      textAlign: TextAlign.start),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton.icon(
                    onPressed: () {
                      openUrl(questionUrl);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      questionUrl,
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    textColor: textContract,
                    splashColor: primaryDark,
                    color: primary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AnswerBlock extends StatelessWidget {
  final AnswerItem answer;

  AnswerBlock({this.answer});

  Widget buildUserBlock(AnswerItem answer) {
    String headline = answer.authorHeadline;

    if (headline.isEmpty) {
      headline = "der Author hat nix über ihn hinterlassen...";
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          buildMaterialIconCircleNetwork(answer.authorAvatarUrl, 68),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(5), child: Text(answer.authorName)),
              Padding(padding: EdgeInsets.all(5), child: Text(headline))
            ],
          )
        ],
      ),
    );
  }

  Widget buildLikeBlock(AnswerItem answer) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          RaisedButton.icon(
            onPressed: () => {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text(
              answer.voteUpCount.toString(),
              style: TextStyle(color: textPrimary),
            ),
            icon: Icon(
              Icons.favorite,
              color: textPrimary,
            ),
            textColor: textPrimary,
            splashColor: primary,
            color: primaryLight,
          ),
          SizedBox(
            width: 10,
          ),
          RaisedButton.icon(
            onPressed: () => {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text(
              answer.commentCount.toString(),
              style: TextStyle(color: textPrimary),
            ),
            icon: Icon(
              Icons.comment,
              color: textPrimary,
            ),
            textColor: textPrimary,
            splashColor: primary,
            color: primaryLight,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final content = answer.contentDe.replaceAll('\\"', '"');
    final content = answer.content.replaceAll('\\"', '"');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      margin: blockMargin,
      child: ResponsiveRowColumn(
        rowColumn: !ResponsiveWrapper.of(context).isSmallerThan(DESKTOP),
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        columnMainAxisSize: MainAxisSize.min,
        rowPadding: EdgeInsets.symmetric(horizontal: 80, vertical: 80),
        columnPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        columnSpacing: 50,
        rowSpacing: 50,
        children: [
          ResponsiveRowColumnItem(
            //rowFlex: 1,
            rowFit: FlexFit.tight,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: buildUserBlock(answer),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: HtmlWidget(content, buildAsync: true),
                ),
                Padding(
                    padding: EdgeInsets.all(5), child: buildLikeBlock(answer))
              ],
            ),
          )
        ],
      ),
    );
  }
}
