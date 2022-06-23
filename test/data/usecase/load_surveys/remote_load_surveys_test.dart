import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_clean_architecture/domain/entities/entities.dart';
import 'package:flutter_clean_architecture/domain/helpers/helpers.dart';

import 'package:flutter_clean_architecture/data/http/http.dart';
import 'package:flutter_clean_architecture/data/usecases/usecases.dart';

class HttpClientSky extends Mock implements HttpClient<List<Map>> {}

void main() {
  String url;
  RemoteLoadSurveys sut;
  HttpClientSky httpClient;
  List<Map> list;

  List<Map> mockValidData() => [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'didAnswer': faker.randomGenerator.boolean(),
          'date': faker.date.dateTime().toIso8601String(),
        },
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'didAnswer': faker.randomGenerator.boolean(),
          'date': faker.date.dateTime().toIso8601String(),
        }
      ];

  PostExpectation mockRequest() => when(
      httpClient.request(url: anyNamed('url'), method: anyNamed('method')));

  void mockHttpData(List<Map> data) {
    list = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSky();
    url = faker.internet.httpUrl();
    sut = RemoteLoadSurveys(httpClient: httpClient, url: url);
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: "get"));
  });

  test('Should return surveys on 200', () async {
    final surveys = await sut.load();

    expect(
      surveys,
      [
        SurveyEntity(
          id: list[0]['id'],
          dateTime: DateTime.parse(list[0]['date']),
          question: list[0]['question'],
          didAnswer: list[0]['didAnswer'],
        ),
        SurveyEntity(
          id: list[1]['id'],
          dateTime: DateTime.parse(list[1]['date']),
          question: list[1]['question'],
          didAnswer: list[1]['didAnswer'],
        ),
      ],
    );
  });

  test(
    'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
    () async {
      mockHttpData([
        {"invalidKey": "invalidValue"}
      ]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    },
  );

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });
}
