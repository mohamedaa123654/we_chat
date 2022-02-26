import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/firebase_options.dart';
import 'package:we_chat/pages/login.dart';
import 'package:we_chat/pages/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Login().id: (context) => Login(),
        Register().id: (context) => Register()
      },
      home: Login(),
    );
  }
}
