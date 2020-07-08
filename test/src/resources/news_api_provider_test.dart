import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FetchTopIds returns a list of ids', () {
    // setup of test case
    final newsApi = NewsApiProvider();
    MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    // expectations
  });
}
