import 'package:flutter/material.dart';
import 'package:todolist/pages/home_page_android.dart';
import '../pages/new_task_page_android.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.amber,
          secondary: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.amber.shade50,
        textTheme: TextTheme(
          headline5: TextStyle(fontWeight: FontWeight.bold),
          headline6: TextStyle(fontStyle: FontStyle.italic, color: Colors.blue)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
          elevation: 5,
          side: BorderSide(width: 1, color: Colors.black
          ),
        ))
      ),
      home: HomePage(),
    );
  }
}