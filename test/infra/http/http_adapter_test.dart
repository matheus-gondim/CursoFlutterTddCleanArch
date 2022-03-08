import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    await client.post(url, headers: headers);
  }
}

class CLientSpy extends Mock implements Client {}

void main() {
  CLientSpy client;
  HttpAdapter sut;
  String url;

  setUp(() {
    client = CLientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    test('Should call post with correct values', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
      ));
    });
  });
}