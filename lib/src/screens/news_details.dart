import 'package:flutter/material.dart';
import 'package:hacker_news/src/models/item_model.dart';
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
        if (!snapshot.hasData) {}
        return Text('');
      },
    );
  }
}
