import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/main_navigation_page.dart';

void main() {
  runApp(const LingJingApp());
}

class LingJingApp extends StatelessWidget {
  const LingJingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '灵境',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: const Color(0xFF6B46C1),
        scaffoldBackgroundColor: const Color(0xFFF5F3FF),
        fontFamily: 'PingFang SC',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6B46C1),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      routerConfig: _router,
    );
  }
}

// 路由配置
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainNavigationPage(),
    ),
  ],
);
