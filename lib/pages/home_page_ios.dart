import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _editingController = TextEditingController();
  List<Widget> rowItens = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Tarefas de Hoje'),
            trailing: CupertinoButton(
              onPressed: () {
                showCupertinoDialog(context: context, builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text('Nov Tarefa'),
                  content: Card(
                    elevation: 0.0,
                    child: Column(
                      children: [
                        CupertinoTextField(
                          controller: _editingController,
                          placeholder: 'Titulo da tarefa',
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: (){
                        setState(() {
                          rowItens.add(RowItem(title: _editingController.text));
                          _editingController.text = '';
                          Navigator.pop(context);
                        });
                      },
                      child: Text('OK'),
                    ),
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ));
              },
              child: Icon(CupertinoIcons.add),
              padding: EdgeInsets.zero,
            ),
          ),
          child: ListView.builder(
              itemCount: rowItens.length,
              itemBuilder: (context, position) => rowItens[position],
          )
      );
  }
}
class RowItem extends StatefulWidget {
  RowItem({Key? key, required this.title, this.isDone = false, this.isSelected = false} ) : super(key: key);

  String title;
  bool isDone;
  bool isSelected;

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.isDone = !widget.isDone;
            widget.isSelected = !widget.isSelected;
          });
        },
        child: CupertinoListTile(
          title: Text(widget.title),
          trailing: widget.isDone ? Icon(CupertinoIcons.check_mark) : null,
          selected: widget.isSelected ? true : false,
        )
    );


        //dados do material app, possivel utilizar clocando o cupertino scafald dentro de um scafald do material app;
      // ListTile(
      // title: Text(widget.title),
      // leading: Icon(CupertinoIcons.square_favorites),
  }
}

