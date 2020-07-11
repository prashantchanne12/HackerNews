import 'package:flutter/material.dart';
import 'package:hacker_news/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({@required this.itemId});

  @override
  Widget build(BuildContext context) {
    final StoriesBloc bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
            if (!snapshot.hasData) {
              return LoadingContainer();
            }
            return buildTile(snapshot.data, context);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item, BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/${item.id}',
            );
          },
          title: Text(
            item.title,
            style: TextStyle(fontFamily: 'mont', fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${item.score} votes',
            style: TextStyle(fontFamily: 'mont'),
          ),
          trailing: Column(
            children: <Widget>[
              Icon(
                Icons.comment,
                color: Colors.deepOrange,
              ),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 10.0,
        ),
      ],
    );
  }
}
