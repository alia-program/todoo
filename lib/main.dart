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
                  title: const Text("first"),
                ),
                body: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const TodoView();
                                }),
                              );
                            },
                            child: const Text('trance')),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widgetList.add(const Column(
                                  children: [TodoView(), TextField()],
                                ));
                                print(widgetList.length);
                              });
                            },
                            child: const Text('追加')),
                      ],
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(children: widgetList),
                    ))
                  ],
                ))));
  }
}
