import 'package:flutter/material.dart';
import 'package:hacker_news/src/screens/new_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HackerNews',
      debugShowCheckedModeBanner: false,
      home: NewsList(),
    );
  }
}
