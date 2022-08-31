import 'package:flutter/cupertino.dart';

class NewTaskPageIOS extends StatelessWidget {
  const NewTaskPageIOS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Container(color: CupertinoColors.activeBlue,));
  }
}
