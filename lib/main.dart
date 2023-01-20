import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/Provider/app_provider.dart';
import 'package:task_app/Screens/Home/home.dart';
import 'package:task_app/Theme/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task App',
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: HomeScreen(),
      ),
    );
  }
}
