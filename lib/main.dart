import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform =
      const MethodChannel('samples.flutter.dev/dateAndTime');
  String _dateAndTime = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getDateAndTime();
  }
  // Swiftのコードのみ
  // Future<void> _getDateAndTime() async {
  //   String dateAndTime;
  //   try {
  //     final String result = await platform.invokeMethod('getDateAndTime');
  //     dateAndTime = 'Date and Time: $result';
  //   } on PlatformException catch (e) {
  //     dateAndTime = "Failed to get date and time: '${e.message}'.";
  //   }

  //   setState(() {
  //     _dateAndTime = dateAndTime;
  //   });
  // }
  // Androidのコードを追加
  Future<void> _getDateAndTime() async {
    String dateAndTime;
    try {
      final String result = await platform.invokeMethod('getDateAndTime');
      dateAndTime = 'Date and Time: $result';
    } on PlatformException catch (e) {
      dateAndTime = "Failed to get date and time: '${e.message}'.";
    } on MissingPluginException {
      // この例外処理を追加します
      dateAndTime =
          "Error: MissingPluginException. The functionality might not be available on this platform.";
    }

    setState(() {
      _dateAndTime = dateAndTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Text(_dateAndTime),
      ),
    );
  }
}
