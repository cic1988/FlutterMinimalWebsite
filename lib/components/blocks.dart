import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
    final content = answer.contentDe.replaceAll('\\"', '"');

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
                  child: ZhihuHtml(content: content),
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

class FooterV1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundDark,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: ResponsiveRowColumn(
        rowColumn: !ResponsiveWrapper.of(context).isMobile,
        children: [
          ResponsiveRowColumnItem(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
              child: Image.asset("assets/images/flutter_logo_mono.png",
                  height: 100, fit: BoxFit.contain),
            ),
          ),
          ResponsiveRowColumnItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: bodyTextStyle.copyWith(
                        fontSize: 14, color: Colors.white, height: 2),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl(
                                  "https://groups.google.com/forum/#!forum/flutter-dev");
                            },
                          text: "flutter-dev@"),
                      TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("https://flutter.dev/tos");
                            },
                          text: "terms"),
                      TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("https://flutter.dev/security");
                            },
                          text: "security"),
                      TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl(
                                  "https://www.google.com/intl/en/policies/privacy");
                            },
                          text: "privacy"),
                      TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("https://flutter-es.io/");
                            },
                          text: "español"),
                      TextSpan(text: "  •  "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("https://flutter.cn/");
                            },
                          text: "社区中文资源"),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      style: bodyTextStyle.copyWith(
                          fontSize: 14, color: Colors.white, height: 1),
                      children: [
                        TextSpan(text: '\n'),
                        TextSpan(
                            text:
                                "Except as otherwise noted, this work is licensed under a Creative Commons Attribution 4.0 International License, and code samples are licensed under the BSD License.",
                            style: bodyTextStyle.copyWith(
                                fontSize: 10, color: Colors.white)),
                        TextSpan(text: '\n'),
                        TextSpan(text: '\n'),
                        TextSpan(text: '\n'),
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
