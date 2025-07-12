import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'theme/theme.dart';
import 'theme/util.dart';
import 'pages/homepage.dart';
import 'pages/no_connection_page.dart';
import 'providers/settings_provider.dart';
import 'pages/splash.dart';
import 'providers/favorites_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()..loadFavorites()),
      ],
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
          title: 'ESENCIA',
          theme: materialTheme.light(),
          darkTheme: materialTheme.dark(),
          themeMode: settings.themeMode,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashPage(),
            '/home': (context) => const ConnectivityHandler(),
            '/no-connection': (context) => const NoConnectionPage(),
          },
        );
      },
    );
  }
}

class ConnectivityHandler extends StatelessWidget {
  const ConnectivityHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ConnectivityResult>>(
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final results = snapshot.data ?? [];
          if (results.isEmpty || results.any((result) => result == ConnectivityResult.none)) {
            return const NoConnectionPage();
          }
          return const MyHomePage();
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}