import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_image/hybrid_image.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.file_copy),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['svg', 'png', 'jpg', 'PNG', 'jpeg'],
              );

              setState(() {
                if (result != null) {
                  file = File(result.files.single.path!);
                }
              });
            },
          ),
          if (file != null) ...{
            Expanded(
              child: HybridImage.file(
                file: file!,
                key: UniqueKey(),
              ),
            ),
          },
          Expanded(
            child: HybridImage.network(imageUrl: 'https://svgur.com/i/bhK.svg'),
          ),
        ],
      ),
    );
  }
}
