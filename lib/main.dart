import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FL Text Viewer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _shownText = 'Hello, World!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_shownText',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Load a text file',
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await FilePicker.platform.pickFiles();
          if (result == null) {
            return;
          }
          print('path: ${result.files.single.path}');
          var path = result.files.single.path;
          if (path == null) {
            return;
          }
          var file = File(path);
          file.readAsString().then((text) {
            print('text: ${text}');
            setState(() {
              _shownText = text;
            });
          });
        },
      ),
    );
  }
}
