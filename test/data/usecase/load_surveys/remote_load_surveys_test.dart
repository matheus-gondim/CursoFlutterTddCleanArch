import 'package:meta/meta.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_clean_architecture/data/http/http.dart';

class RemoteLoadSurveys {
  final HttpClient httpClient;
  final String url;

  RemoteLoadSurveys({@required this.httpClient, @required this.url});

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}

class HttpClientSky extends Mock implements HttpClient {}

void main() {
  String url;
  RemoteLoadSurveys sut;
  HttpClientSky httpClient;

  setUp(() {
    httpClient = HttpClientSky();
    url = faker.internet.httpUrl();
    sut = RemoteLoadSurveys(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: "get"));
  });
}
