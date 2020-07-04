import 'package:flutter/material.dart';

class FutureContainer<T> extends StatelessWidget {

  final Future<T> future;
  final Widget Function(T) implementation;
  final bool progress;
  final String loadingText;

  FutureContainer({
    @required this.future,
    @required this.implementation,
    this.progress,
    this.loadingText
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                  if (progress != null && progress == true) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Center(child: Text(loadingText));
              default: {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return implementation(snapshot.data);
              }
            }
          },
      );
  }
}