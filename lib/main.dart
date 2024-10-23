import 'package:flutter/material.dart';
import 'package:todoo/todo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MemoPage(),
    );
  }
}

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  final focusNode = FocusNode();
  final List<Widget> widgetList = [];

  @override
  Widget build(BuildContext context) {
    return Focus(
        focusNode: focusNode,
        child: GestureDetector(
            onTap: focusNode.requestFocus,
            onLongPress: focusNode.requestFocus,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 143, 195, 255),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
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
                            widgetList.add(Column(
                              children: [
                                TodoView(
                                  //constするとitem追加できない注意
                                  items: [],
                                ),
                                const TextField()
                              ],
                            ));
                            print(widgetList.length);
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ))
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(children: widgetList),
                    ))
                  ],
                ))));
  }
}
