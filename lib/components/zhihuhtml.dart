import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ZhihuHtml extends StatelessWidget {
  final String content;

  ZhihuHtml({this.content});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      content,
      //factoryBuilder: () => _ZhihuWidgetFactory(),
      customWidgetBuilder: (e) {
        if (e.localName == 'blockquote') {
          return null;
        } else if (e.localName == 'p') {
          //print(e.innerHtml);
          return null;
        } else if (e.localName == 'img') {
          return Center(
            child: Image.network(e.attributes['src']),
          );
        }
        return null;
      },
    );
  }
}

class _ZhihuWidgetFactory extends WidgetFactory {
  BuiltPiece _resetText(BuiltPiece piece, String content) {
    final text = piece.text;
    List.unmodifiable(text.bits).forEach((bit) => bit.detach());
    text.addText(content);
    return piece;
  }

  @override
  void parseTag(NodeMetadata meta, String tag, Map<dynamic, String> attrs) {
    if (tag == 'p') {
      meta.op = BuildOp(onPieces: (_, pieces) {
        String content = pieces.first?.text.first?.data;
        if (content != null && content.isNotEmpty) {
          _resetText(pieces.first, content.replaceAll('.', '. '));
        }
        return pieces;
      });
    }

    super.parseTag(meta, tag, attrs);
  }
}
