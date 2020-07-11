import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/widgets/refresh.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

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
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Refresh(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                bloc.fetchItem(snapshot.data[index]);
                return NewsListTile(itemId: snapshot.data[index]);
              },
            ),
          );
        }
      },
    );
  }
}
