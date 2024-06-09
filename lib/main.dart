import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  // URL 전략으로 path 방식을 사용하도록 설정합니다.
  setPathUrlStrategy();

  runApp(
    // 앱을 ProviderScope로 감싸서 Riverpod를 사용할 수 있도록 합니다.
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// GoRouter를 사용하여 라우트를 정의합니다.
final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/', // 루트 경로
    builder: (BuildContext context, GoRouterState state) {
      return const RootPage(); // 루트 경로에 대응하는 위젯을 반환합니다.
    },
    routes: <RouteBase>[
      GoRoute(
        path: 'another', // '/another' 경로
        builder: (BuildContext context, GoRouterState state) {
          return const AnotherPage(); // '/another' 경로에 대응하는 위젯을 반환합니다.
        },
      )
    ],
  ),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router, // GoRouter 설정을 사용합니다.
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Root Page'), // 앱바 제목
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Root Page'), // 화면 중앙에 표시되는 텍스트
            const SizedBox(height: 20), // 간격을 추가합니다.
            ElevatedButton(
              onPressed: () {
                context.go('/another'); // '/another' 경로로 이동합니다.
              },
              child: const Text('Go to another page'), // 버튼 텍스트
            ),
          ],
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'), // 앱바 제목
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Another Page'), // 화면 중앙에 표시되는 텍스트
            const SizedBox(height: 20), // 간격을 추가합니다.
            ElevatedButton(
              onPressed: () {
                context.go('/'); // 루트 경로로 이동합니다.
              },
              child: const Text('Go back to root page'), // 버튼 텍스트
            ),
          ],
        ),
      ),
    );
  }
}
