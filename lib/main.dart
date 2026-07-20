import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

/// 앱 전체 공통 색상
class AppColors {
  static const scaffoldGray = Color(0xFFF1F1F1); // 전체 배경 (연회색)
  static const appBarGray = Color(0xFFE7E7E7); // 상단바 배경
  static const cardWhite = Colors.white;
  static const textDark = Color(0xFF222222);
  static const textGray = Color(0xFF6E6E6E);
  static const inputFill = Color(0xFFEDEDED);
  static const inputBorder = Color(0xFF9A9A9A);
  static const loginButton = Color(0xFF4B4B4B); // 로그인 버튼 (진회색)
  static const signupButton = Color(0xFFD6D6D6); // 회원가입 버튼 (연회색)
  static const teal = Color(0xFF17B6C4); // 로고/포인트 청록
  static const cardLavender = Color(0xFFEFECF7); // 상황 카드 배경
  static const heartRed = Color(0xFFE0524B);
  static const burnOrange = Color(0xFFF08A2E);
  static const fabDark = Color(0xFF3F3F3F);
  static const calendarSelectedRed = Color(0xFFE1483F);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '응급 환자 도우미',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [Locale('ko', 'KR'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldGray,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.teal,
          brightness: Brightness.light,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
