import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'no_connection_page.dart';
import 'config.dart';
import 'comparar.dart';
import 'home_content_page.dart';
import 'favoritos_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  final List<Widget> _pages = const [
    HomeContentPage(),    
    ConfigPage(),
    CompararPage(),
  ];

  final List<String> _titles = [
    'Inicio',
    'Configuración',
    'Comparar Personajes',
    'Favoritos',
  ];

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _setupConnectivityListener();
  }

  Future<void> _initConnectivity() async {
    late List<ConnectivityResult> results;
    try {
      results = await _connectivity.checkConnectivity();
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
      return;
    }

    if (!mounted) return;
    
    _updateConnectionStatus(results);
  }

  void _setupConnectivityListener() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (!_hasConnection(results) && mounted) {
      _navigateToNoConnection();
    }
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.isNotEmpty && results.any((result) => result != ConnectivityResult.none);
  }

  void _navigateToNoConnection() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NoConnectionPage()),
    );
  }

  void _onItemTapped(int index) {
    Navigator.pop(context);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.compare),
              title: const Text('Comparar'),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritosPage()));
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}