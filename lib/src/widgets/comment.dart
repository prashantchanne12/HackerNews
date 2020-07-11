import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment(
      {@required this.itemId, @required this.itemMap, @required this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: 16.0 * (depth + 1),
            ),
            title: buildText(snapshot.data),
            subtitle: Text(
              snapshot.data.by == null
                  ? 'comment is deleted'
                  : snapshot.data.by,
              style: TextStyle(
                fontFamily: 'mont',
                color: Colors.deepOrange,
              ),
            ),
          ),
          Divider(
            height: 10.0,
          ),
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', " ' ")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '')
        .replaceAll('&quot;', ' " ')
        .replaceAll('&gt;', '>')
        .replaceAll('&#x2F;', '/')
        .replaceAll('<i>', '')
        .replaceAll('</i>', '');
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'mont',
      ),
    );
  }
}
