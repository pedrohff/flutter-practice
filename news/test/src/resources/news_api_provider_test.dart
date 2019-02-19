import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test_api/test_api.dart';

void main() {

  test('FetchTopIds returns a list of ids', () async{
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1,2,3,4]), 200);
    });
    
    final ids = await newsApi.fetchTopIds();
    expect(ids, [1,2,3,4]);
  });

  test('Fetch item', () async{
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final props = {'id': 123};
      return Response(json.encode(props), 200);
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);

  });
}