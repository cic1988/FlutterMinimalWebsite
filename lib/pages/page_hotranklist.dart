import 'package:flutter/material.dart';
import 'package:minimal/model/hotrankitem.dart';
import 'package:minimal/api/zhihu.dart';
import 'package:minimal/components/components.dart';

class HotRankList extends StatefulWidget {
  @override
  HotRankListState createState() => new HotRankListState();
}

class HotRankListState extends State<HotRankList> {
  Widget rankNumber(String rank) {
    return Expanded(
        flex: 1,
        child: Column(
          children: <Widget>[
            Container(
              child: Text(rank,
                  style: TextStyle(
                      color:
                          int.parse(rank) <= 3 ? Colors.red : Colors.green,
                      fontSize: 18.0)),
              alignment: Alignment.topLeft,
            )
          ],
        ));
  }

  Widget hotCard(RankItem item) {
    return new Container(
      margin: const EdgeInsets.all(5),
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: new FlatButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context,  '/question?id=${item.id}');
          },
          child: new Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                rankNumber(item.rank),
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              item.questionTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  height: 1.1,
                                  color: Colors.black),
                            ),
                            padding:
                                const EdgeInsets.only(bottom: 10.0, right: 4.0),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            child: Text(item.hot + '0K Hot',
                                style: TextStyle(color: Colors.grey)),
                            alignment: Alignment.topLeft,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  Widget rankList() {
    return FutureBuilder<List<RankItem>>(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    RankItem topic = snapshot.data[index];
                    return hotCard(topic);
                  });
            }
        }
      },
      future: API.topics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: MenuBar()),
        SizedBox(height: 20),
        Expanded(child: rankList())
      ]),
      backgroundColor: Colors.white,
    );
  }
}
