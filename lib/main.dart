import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MainApp(),
    ));

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List _todos = [];

  void handleDoneBtn(value) {
    _todos.remove(value);
    setState(() => _todos = _todos);
  }

  Widget todoContainer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.73,
      margin: EdgeInsets.only(top: 40),
      child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            String item = _todos[(_todos.length - 1) - index];

            return ListTileTheme(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 3), // changes position of shadow
                    )
                  ],
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 15, right: 10),
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () => {handleDoneBtn(item)},
                        child: Text('Done'))
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget noTodoRender() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Jong has no item on todo list.',
        style: TextStyle(fontSize: 32),
        textAlign: TextAlign.center,
      ),
    );
  }

  void showDi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TestAlertDialog((value) => setState(() => _todos.add(value)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jong\'s todo list'),
      ),
      body: (_todos.length != 0) ? todoContainer() : noTodoRender(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDi(),
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class TestAlertDialog extends StatefulWidget {
  final onPressed;
  TestAlertDialog(this.onPressed);
  @override
  _TestAlertDialogState createState() => _TestAlertDialogState(onPressed);
}

class _TestAlertDialogState extends State<TestAlertDialog> {
  final onPressed;

  _TestAlertDialogState(this.onPressed);

  String inputText = '';

  void handleSubmitTodo(value) {
    onPressed(value);
    Navigator.of(context).pop();
  }

  void handleChange(value) {
    setState(() => inputText = value);
  }

  @override
  Widget build(BuildContext context) {
    Widget addButton = ElevatedButton(
      child: Text("Add todo"),
      onPressed: () {
        Navigator.of(context).pop();
        onPressed(inputText);
      },
    );

    return AlertDialog(
      title: Text("Add a new Todo."),
      content: TextField(
        onSubmitted: handleSubmitTodo,
        onChanged: handleChange,
        decoration: InputDecoration(
            labelText: 'Title', contentPadding: EdgeInsets.only(bottom: 0)),
      ),
      actions: [
        addButton,
      ],
    );
  }
}

showAlertDialog(BuildContext context, onPressed) {
  // Create button
  Widget addButton = ElevatedButton(
    child: Text("Add todo"),
    onPressed: () {
      // Navigator.of(context).pop();
    },
  );

  void handleSubmitTodo(value) {
    onPressed(value);
    Navigator.of(context).pop();
  }

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Add a new Todo."),
    content: TextField(
      onSubmitted: handleSubmitTodo,
      decoration: InputDecoration(
          labelText: 'Title', contentPadding: EdgeInsets.only(bottom: 0)),
    ),
    actions: [
      addButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
