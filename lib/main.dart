import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/MySpashScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(
      child: MaterialApp(
        title: 'rider app',
        theme: ThemeData(primarySwatch: Colors.blue),
        // home: Scaffold(
        //   appBar: AppBar(
        //     title: const Text("welcome to the rider app"),
        //     backgroundColor: Colors.blue,
        //   ),
        // ),
        home: const Myspashscreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyApp>()!.restartApp();
  }

  MyApp({this.child});
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sort_child_properties_last
    return KeyedSubtree(child: widget.child!, key: key);
  }
}
