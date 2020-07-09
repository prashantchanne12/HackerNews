import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        // returns widget when future is resolved
        // Only returns widgets that fits in size of screen
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Text('Im visible $index ${snapshot.data}')
                : Text('I have not fetched the data yet');
          },
        );
      },
    );
  }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'Hello',
    );
  }
}
