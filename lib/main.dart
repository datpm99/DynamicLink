import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

Future<void> initialDynamicLink() async {
  final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

  //Terminated State (app kill).
  if (initialLink != null) {
    final Uri deepLink = initialLink.link;
    debugPrint("deepLink: $deepLink");
  }

  //Background / Foreground State.
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    final Uri deepLink = dynamicLinkData.link;
    debugPrint("deepLink: $deepLink");
  }).onError((error) {
    debugPrint('dynamicLink error: ${error.message}');
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initialDynamicLink();

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Link'),
      ),
      body: const Center(
        child: Text('Hello world', style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
