import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'theme/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final textTheme = createTextTheme(
          context,
          'Roboto',
          'Playfair Display',
        );

        final theme = MaterialTheme(textTheme);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mi app con tema personalizado',
          theme: theme.light(),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Center(
        child: Text(
          'Hola con el nuevo tema!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
