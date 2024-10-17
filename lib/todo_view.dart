import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  final _items = Iterable.generate(20).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex--;
              }
              var item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          },
          children: <Widget>[
            for (var item in _items)
              Row(
                key: ValueKey(item),
                //複数のviewを配置
                children: <Widget>[
                  //Expandedは最大限広げる
                  Expanded(
                    //Containerは色・サイズ・childを指定できる
                    child: Container(
                      //線の表示は同じ箱に入れて同じ範囲適用
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 173, 173, 173)),
                        ),
                      ),
                      //TextField
                      child: EditableText(
                        controller:
                            TextEditingController(text: item.toString()),
                        focusNode: FocusNode(),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 150, 150, 150),
                          fontSize: 40,
                        ),
                        cursorColor: Colors.black,
                        backgroundCursorColor: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.reorder,
                      size: 40,
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
