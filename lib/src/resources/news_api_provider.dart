import 'dart:convert';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:http/http.dart' show Client;

final _rootUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_rootUrl/topstories.json');
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItems(int id) async {
    final response = await client.get('$_rootUrl/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
