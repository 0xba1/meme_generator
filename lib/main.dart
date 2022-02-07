import 'package:flutter/material.dart';
import 'package:meme_generator/controllers/meme_provider.dart';
import 'package:meme_generator/views/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meme Generator',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (_) => MemeProvider(), child: const Home()),
    );
  }
}

