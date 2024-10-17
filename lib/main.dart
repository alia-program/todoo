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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return Focus(
        focusNode: focusNode,
        child: GestureDetector(
            onTap: focusNode.requestFocus,
            onLongPress: focusNode.requestFocus,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("first"),
              ),
              body: const Center(child: TodoView()),
            )));
  }
}
