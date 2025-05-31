import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ShibliShortsApp());
}

class ShibliShortsApp extends StatelessWidget {
  const ShibliShortsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shibli Shorts',
      theme: ThemeData.dark(),
      home: const HomeTabs(),
      debugShowCheckedModeBanner: false,
    );
  }
}
