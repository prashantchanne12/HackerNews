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
    deleted = parsedJson['deleted'];
    type = parsedJson['type'];
    time = parsedJson['time'];
    text = parsedJson['text'];
    dead = parsedJson['dead'];
    parent = parsedJson['parent'];
    kids = parsedJson['kids'];
    url = parsedJson['url'];
    score = parsedJson['score'];
    title = parsedJson['title'];
    descendants = parsedJson['descendants'];
  }
}
