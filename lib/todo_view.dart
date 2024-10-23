import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoo/main.dart';

class TodoView extends StatefulWidget {
  TodoView({required this.items});
  List<ItemData> items;

  @override
  State<TodoView> createState() => _TodoViewState();
}

class ItemData {
  int id;
  String? text;
  bool check;

  TextEditingController _controller;
  //コンストラクタの定型文
  ItemData(this.id, this.text, this._controller, this.check);
}

class _TodoViewState extends State<TodoView> {
  //final _items = <ItemData>[];
  //  //.generate(3, (index) => ItemData(index, '', TextEditingController(text: "")));

  int index = 0;
  int id = 0;

  //コントローラーの破棄
  @override
  void dispose() {
    widget.items[index]._controller.dispose();
    super.dispose();
  }

  //コントローラーの更新
  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty) {
      widget.items[index]._controller =
          TextEditingController(text: widget.items[index].text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      margin: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 128, 185, 255),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                  iconSize: 30,
                ),
                const Expanded(
                    child: Center(
                  child: Text(
                    'TODO',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35),
                  ),
                )),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _addItem();
                    });
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  iconSize: 35,
                ),
              ],
            ),
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
      widget.items.remove(item);
    });
  }

  void _addItem() {
    widget.items.add(ItemData(id++, '', TextEditingController(), false));
  }

  ReorderableListView _addListView() {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex--;
          }
          var item = widget.items.removeAt(oldIndex);
          widget.items.insert(newIndex, item);
        });
      },
      //リストのアイテムたちを生成
      children: <Widget>[
        for (var item in widget.items)
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
            //rowは横並びの配列を作れる
            child: Row(
              key: ValueKey(item),
              //複数のviewを配置
              children: <Widget>[
                Checkbox(
                    value: item.check,
                    onChanged: (value) {
                      setState(() {
                        item.check = value!;
                      });
                    }),

                //Expandedは最大限広げる
                Expanded(
                  //Containerは色・サイズ・childを指定できる
                  child: Container(
                    margin: const EdgeInsets.all(5),
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
                          index = widget.items.indexOf(item);
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
                  padding: EdgeInsets.all(10),
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
