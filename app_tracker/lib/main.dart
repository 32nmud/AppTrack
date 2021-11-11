import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'config_parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTrakcer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AppTracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConfigParser parser = new ConfigParser();

  @override
  Widget build(BuildContext context) {
    if (parser.checkIfConfigFileExists()) {
      return mainScreen();
    } else {
      return setConfigScreen();
    }
  }

  Widget mainScreen() => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Success!',
              ),
            ],
          ),
        ),
      );

  Widget setConfigScreen() => Scaffold(
        appBar: AppBar(
          title: Text("First Time Setup"),
        ),
        body: Center(
          child: setDatabaseButton(),
        ),
      );

  Widget setDatabaseButton() => ElevatedButton(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['db'],
            allowMultiple: false);
        if (result != null) {
          parser.createConfigFile(
              result.paths.map((path) => File(path.toString())).toList()[0]);
        }
        setState(() {});
      },
      child: const Text("Select the database file!"));
}
