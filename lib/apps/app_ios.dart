import 'package:flutter/cupertino.dart';
import 'package:todolist/pages/home_page_ios.dart';
import 'package:todolist/pages/new_task_page_android.dart';

import '../pages/new_task_page_IOS.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: NewTaskPageIOS(),
    );
  }
}
