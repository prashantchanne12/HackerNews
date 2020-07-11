import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/widgets/comment.dart';
import '../blocs/comments_provider.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({@required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HackerNews',
          style: TextStyle(
            fontFamily: 'mont',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xfff0932b),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        }
        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!snapshot.hasData) {
              return Text('Loading...');
            }

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));

    if (item != null) {
      final commentsList = item.kids.map((kidId) {
        return Comment(
          itemId: kidId,
          itemMap: itemMap,
          depth: 0,
        );
      }).toList();
      children.addAll(commentsList);
    }

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel item) {
    return item != null
        ? Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(10.0),
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'mont',
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
          )
        : Text('Loading');
  }
}
