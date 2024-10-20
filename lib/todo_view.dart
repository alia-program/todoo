import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class ItemData {
  int id;
  String? text;

  TextEditingController _controller;
  //コンストラクタの定型文
  ItemData(this.id, this.text, this._controller);
}

class _TodoViewState extends State<TodoView> {
  final _items = <ItemData>[];
  //  //.generate(3, (index) => ItemData(index, '', TextEditingController(text: "")));
  String content = "";
  int index = 0;
  int id = 0;

  @override
  void dispose() {
    _items[index]._controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (_items.isNotEmpty) {
      _items[index]._controller =
          TextEditingController(text: _items[index].text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _addItem();
                    });
                  },
                  child: const Text('追加')),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('削除')),
            ],
          ),
          Expanded(
            child: _addListView(),
          )
        ],
      ),
    );
  }

  void _removeItem(ItemData item) {
    setState(() {
      _items.remove(item);
    });
  }

  void _addItem() {
    _items.add(ItemData(id++, '', TextEditingController()));
  }

  ReorderableListView _addListView() {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex--;
          }
          var item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
      //リストのアイテムたちを生成
      children: <Widget>[
        for (var item in _items)
          Slidable(
            key: ValueKey(item),
            endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    label: '削除',
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    onPressed: (context) {
                      _removeItem(item);
                    },
                  ),
                ]),
            child: Row(
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
                    //入力画面
                    child: EditableText(
                      controller: item._controller,
                      onChanged: (newText) {
                        setState(() {
                          item.text = newText;
                          index = _items.indexOf(item);
                        });
                      },
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

                //padding付きのアイコン
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(
                    Icons.reorder,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
