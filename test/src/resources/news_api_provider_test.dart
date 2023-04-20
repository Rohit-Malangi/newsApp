import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:news/src/resources/news_api_provider.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(jsonEncode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('fetch item return a ItemModel', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {
        'id': 123,
        'deleted': false,
        'type': 'typedata',
        'by': 'bydata',
        'time': 0,
        'text': 'textdata',
        'dead': false,
        'parent': 0,
        'kids': [1, 2, 3],
        'url': 'urldata',
        'score': 0,
        'title': 'titledata',
        'descendants': 0
      };
      return Response(jsonEncode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(123);
    expect(item.id, 123);
  });
}
