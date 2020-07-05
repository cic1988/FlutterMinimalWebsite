import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ZhihuHtml extends StatelessWidget {
  final String content;

  ZhihuHtml({this.content});

  /*final smilieOp = BuildOp(
    onPieces: (meta, pieces) {
      final alt = meta.domElement.attributes['alt'];
      final text = kSmilies.containsKey(alt) ? kSmilies[alt] : alt;
      return pieces..first?.text?.addText(text);
    },
  );*/

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(content, customWidgetBuilder: (e) {
      print(e);
      if (e.localName == 'blockquote') {
        print(e.text);
      } else if (e.localName == 'p') {
        print(e.text);
      }
    });
  }
}
