import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _editingController = TextEditingController();

  List<Widget> rowItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas para hoje'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: rowItems.length,
        itemBuilder: (BuildContext context, int position){
          return rowItems[position];
        },
        separatorBuilder: (BuildContext context, int position) => Divider(color: Colors.grey.shade600,),
      ),

      // ListView.builder(
      //     itemCount: rowItems.length,
      //     itemBuilder: (BuildContext context, int position) {
      //       return rowItems[position];
      //     }
      // ),
      //   actions: [
      //     InkWell(
      //       onTap: () {
      //         print('buscar');
      //         },
      //       child: const Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 20),
      //           child: Icon(Icons.search),
      //       ),
      //     ),
      //     InkWell(
      //       onTap: () {
      //         print('add');
      //       },
      //       child: const Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 20),
      //         child: Icon(Icons.add),
      //       ),
      //     )
      // ],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //           content: Text('Clicou no floatActioButton'),
          //           action: SnackBarAction(label: 'Desfazer', onPressed: () {print('Cliclou no desfazer');}),
          //       ));
          //
          showDialog(context: context, builder: (BuildContext contex) {
            return AlertDialog(
              title: Text('Nova tarefa'),
              content: Text('Informa a tarefa'),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(controller: _editingController,),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          rowItems.add(RowItem(title: _editingController.text));
                          _editingController.text = '';
                        });
                      },
                          child: Text('OK')
                      ),
                      TextButton(
                        style: TextButton.styleFrom(textStyle: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
                      ),
                    ]
                )



              ],
            );
          });
        },

        child: const Icon(Icons.add),
      ),
      // drawer: Drawer(
      //   child: Text('Configuração')
      // ),
      //  drawer open a screen left side
    );
  }
}

class RowItem extends StatefulWidget {
  RowItem({Key? key, required this.title, this.isDone = false, this.isSelected = false}) : super(key: key);

  String title;
  bool isDone;
  bool isSelected;

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      // subtitle: Text('Sub'),
      // leading: Icon(Icons.abc),
      trailing: widget.isDone ? Icon(Icons.done) : null,
      // enabled: true,
      selected: widget.isSelected ? true : false,

      onTap: () {
        setState(() {
          widget.isDone = !widget.isDone;
          widget.isSelected = !widget.isSelected;
        });
      },
    );
  }
}