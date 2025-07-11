import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'theme/theme.dart';
import 'theme/util.dart';
import 'pages/homepage.dart';
import 'pages/no_connection_page.dart';
import 'providers/settings_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, 'Roboto', 'Playfair Display');
    final materialTheme = MaterialTheme(textTheme);

    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mi app con tema personalizado',
          theme: materialTheme.light(),
          darkTheme: materialTheme.dark(),
          themeMode: settings.themeMode,
          home: FutureBuilder(
            future: Connectivity().checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == ConnectivityResult.none) {
                  return const NoConnectionPage();
                }
                return const MyHomePage();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        );
      },
    );
  }
}