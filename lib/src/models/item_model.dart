import 'dart:convert';

class ItemModel {
  int id;
  bool deleted;
  String by;
  String type;
  int time;
  String text;
  bool dead;
  int parent;
  List<dynamic> kids;
  String url;
  int score;
  String title;
  int descendants;

  // Named Constructor
  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    deleted = parsedJson['deleted'] ?? false;
    dead = parsedJson['dead'] ?? false;
    type = parsedJson['type'];
    time = parsedJson['time'];
    text = parsedJson['text'] ?? '';
    parent = parsedJson['parent'];
    kids = parsedJson['kids'] ?? [];
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'] ?? 0;
  }

  ItemModel.fromDb(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    type = parsedJson['type'];
    time = parsedJson['time'];
    text = parsedJson['text'];
    parent = parsedJson['parent'];
    kids = jsonDecode(parsedJson['kids']);
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    deleted = parsedJson['deleted'] == 1;
    dead = parsedJson['dead'] == 1;
    descendants = parsedJson['descendants'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'parent': parent,
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants,
      'dead': dead ? 1 : 0,
      'deleted': deleted ? 1 : 0,
      'kids': jsonEncode(kids),
    };
  }
}
