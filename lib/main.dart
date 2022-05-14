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
      title: 'FL Text Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FL Text Viewer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose a text file to open it.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Open a text file',
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
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(path),
                    ),
                    body: SingleChildScrollView(
                      child: Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(text),
                        ),
                      ),
                    ),
                  );
                }
              )
            );
          });
        }
      ),
    );
  }
}
