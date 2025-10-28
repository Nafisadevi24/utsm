import 'package:flutter/material.dart';
import 'repository/data_repository.dart'; 
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/main_page.dart';
import 'pages/home_page.dart';
import 'pages/add_edit_page.dart';
import 'pages/detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await DataRepository().loadInitialData(); 
  runApp(const CineLogApp());
}

class CineLogApp extends StatelessWidget {
  const CineLogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineLog+',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF1565C0),
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF0D47A1)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName: (_) => const SplashPage(),
        LoginPage.routeName: (_) => LoginPage(),
        SignupPage.routeName: (_) => SignupPage(),
        MainPage.routeName: (_) => MainPage(),
        HomePage.routeName: (_) => HomePage(),
        AddEditPage.routeName: (_) => AddEditPage(),
        DetailPage.routeName: (_) => DetailPage(),
      },
    );
  }
}
