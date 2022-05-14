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
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00003F),
          foregroundColor: Colors.white,
        ),
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
        title: const Text("FL Text Viewer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Choose a text file to open it.'),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: _openFile,
              child: const Text("Open a text file"),
            )
          ],
        ),
      ),
    );
  }

  void _openFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    final path = result.files.single.path;
    if (path == null) {
      return;
    }
    final file = File(path);
    file.readAsString().then((text) {
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
      }
    );
  }
}
