import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/main_navigation_page.dart';
import 'constants/app_colors.dart';

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
        // 主色调
        primaryColor: AppColors.primaryBlue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          primary: AppColors.primaryBlue,
          secondary: AppColors.primaryBlueDark,
        ),
        
        // 背景色
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        
        // 字体
        fontFamily: 'PingFang SC',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: AppColors.grayTitle,
            height: 1.18,
          ),
          displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.grayTitle,
            height: 1.21,
          ),
          displaySmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.grayTitle,
            height: 1.27,
          ),
          bodyLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: AppColors.grayText,
            height: 1.41,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: AppColors.grayText,
            height: 1.33,
          ),
          bodySmall: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: AppColors.graySecondary,
            height: 1.38,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.graySecondary,
            height: 1.45,
          ),
        ),
        
        // AppBar主题
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.grayTitle,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.grayTitle,
          ),
        ),
        
        // 卡片主题
        cardTheme: CardThemeData(
          color: AppColors.cardBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.black.withOpacity(0.08),
        ),
        
        // 输入框主题
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.inputBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: const TextStyle(
            color: AppColors.graySecondary,
            fontSize: 17,
          ),
        ),
        
        // 按钮主题
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: AppColors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        
        // 分割线主题
        dividerTheme: const DividerThemeData(
          color: AppColors.grayDivider,
          thickness: 0.5,
          space: 1,
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
