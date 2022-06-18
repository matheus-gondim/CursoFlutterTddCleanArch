import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_architecture/ui/pages/pages.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {}

void main() {
  SplashPresenterSpy presenter;
  StreamController<String> navigateToController;

  void initStreams() {
    navigateToController = StreamController<String>();
  }

  void closeStreams() {
    navigateToController.close();
  }

  void mockStreams() {
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    initStreams();
    mockStreams();

    final splashPage = GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashPage(presenter: presenter)),
        GetPage(
          name: '/any_router',
          page: () => Scaffold(body: Text('fake page')),
        ),
      ],
    );
    await tester.pumpWidget(splashPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets(
    'Should present spinner on page load',
    (WidgetTester tester) async {
      await loadPage(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Should call loadCurrentAccount on page load',
    (WidgetTester tester) async {
      await loadPage(tester);

      verify(presenter.checkAccount()).called(1);
    },
  );

  testWidgets(
    'Should change page',
    (WidgetTester tester) async {
      await loadPage(tester);

      navigateToController.add('/any_router');
      await tester.pumpAndSettle();

      expect(Get.currentRoute, '/any_router');
      expect(find.text('fake page'), findsOneWidget);
    },
  );

  testWidgets(
    'Should not change page',
    (WidgetTester tester) async {
      await loadPage(tester);

      navigateToController.add('');
      await tester.pump();
      expect(Get.currentRoute, '/');

      navigateToController.add(null);
      await tester.pump();
      expect(Get.currentRoute, '/');
    },
  );
}
