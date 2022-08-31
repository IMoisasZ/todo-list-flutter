import 'package:flutter/material.dart';

import '../data/task.dart';

class NewTaskPageAndroid extends StatefulWidget {
  const NewTaskPageAndroid({Key? key}) : super(key: key);

  @override
  State<NewTaskPageAndroid> createState() => _NewTaskPageAndroidState();
}

class _NewTaskPageAndroidState extends State<NewTaskPageAndroid> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String? _titleError;
  String? _descError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
          'Nova tarefa'),
        centerTitle: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Titulo',
                    errorText: _titleError,
                    border: OutlineInputBorder(),
                  ),
                  controller: _titleController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    hintText: 'Digite aqui a descrião da tarefa',
                    errorText: _descError,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 6,
                ),
              ),

              Expanded(child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: Text('Criar'.toUpperCase()),
                    onPressed: () => _createClick(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _createClick(BuildContext context) {
    String title = _titleController.text.toString();
    String desc = _descController.text.toString();

    setState(() => {
      _titleError = title.isEmpty ? 'O titulo deve ser preenchido' : null,
      _descError =  desc.isEmpty ?  'A descrição deve ser preenchida' : null,
    });

    if(title.isEmpty || desc.isEmpty){
      return;
    }

    _titleError = '';
    _descError = '';


    final task = Task(title: title, description: desc);
    Navigator.pop(context, task);
  }
}



