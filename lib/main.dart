// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode:
      themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(),

    );
  }
}