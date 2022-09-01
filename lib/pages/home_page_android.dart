import 'package:flutter/material.dart';
import 'package:todolist/pages/new_task_page_android.dart';
import 'package:todolist/repository/task_repository.dart';
import '../data/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskRepository repository = TaskRepository();
  List<Task> rowItems = [];

  @override
  void initState(){
    repository.getTasks().then((value) => rowItems.addAll(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas para hoje'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: rowItems.length,
        itemBuilder: (BuildContext context, int position) {
          final task = rowItems[position];
          return RowItem(
              task: task,
            onDeleteItem: () => _deleteTask(position, task, context),
            onValueChange: () {
              rowItems[position].isDone = !rowItems[position].isDone;
              _saveList();
          },);
        },
        separatorBuilder: (BuildContext context, int position) =>
            Divider(color: Colors.grey.shade600,),
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
          //Using the showDialog
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //           content: Text('Clicou no floatActioButton'),
          //           action: SnackBarAction(label: 'Desfazer', onPressed: () {print('Cliclou no desfazer');}),
          //       ));
          //
          // showDialog(context: context, builder: (BuildContext contex) {
          //   return AlertDialog(
          //     title: Text('Nova tarefa'),
          //     content: Text('Informa a tarefa'),
          //     actions: [
          //       Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 10.0),
          //         child: TextField(controller: _editingController,),
          //       ),
          //       Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children:[
          //             TextButton(onPressed: () {
          //               Navigator.of(context).pop();
          //               setState(() {
          //                 rowItems.add(RowItem(title: _editingController.text));
          //                 _editingController.text = '';
          //               });
          //             },
          //                 child: Text('OK')
          //             ),
          //             TextButton(
          //               style: TextButton.styleFrom(textStyle: TextStyle(fontWeight: FontWeight.bold)),
          //               onPressed: () {
          //                 Navigator.of(context).pop();
          //               },
          //               child: const Text('Cancelar', style: TextStyle(color: Colors.red),),
          //             ),
          //           ]
          //       )
          //
          //
          //
          //     ],
          //   );
          //Using a route
          _createTask(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createTask(BuildContext context) {
    final Future<Task?> future = Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => NewTaskPageAndroid()));
            future.then((task) => {
              setState(() {
                if(task != null){
                  rowItems.add(task);
                  _saveList();
                }
              })
            });
  }

  void _deleteTask(int position, Task task, BuildContext context) {
    setState(() {
      rowItems.removeAt(position);
      _saveList();

      final snackBar = SnackBar(
        content: Text('Tarefa ${task.title} excluida!'),
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              rowItems.insert(position, task);
              _saveList();
            });
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void _saveList() {
    repository.saveTasks(rowItems);
  }
}
// drawer: Drawer(
//   child: Text('Configuração')
// ),
//  drawer open a screen left side


class RowItem extends StatefulWidget {
  RowItem({Key? key, required this.task, this.isSelected = false, required this.onValueChange, required this.onDeleteItem}) : super(key: key);

  Task task;
  bool isSelected;
  VoidCallback onValueChange;
  VoidCallback onDeleteItem;

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        widget.onDeleteItem();
      },
      background: Container(
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
            )
        ),
        ),
      ),
      child: ListTile(
        title: Text(widget.task.title, style: Theme.of(context).textTheme.headline5,),
        subtitle: Text(widget.task.description, style: Theme.of(context).textTheme.headline6,),
        // subtitle: Text('Sub'),
        // leading: Icon(Icons.abc),
        trailing: widget.task.isDone ? Icon(Icons.done) : null,
        // enabled: true,
        selected: widget.isSelected ? true : false,

        onTap: () {
          setState(() {
            widget.task.isDone = !widget.task.isDone;
            widget.isSelected = !widget.isSelected;
            widget.onValueChange();
          });
        },
      ),
    );
  }
}