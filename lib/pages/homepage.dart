import 'package:flutter/material.dart';
import 'profile.dart';
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

  final List<Widget> _pages = const [
    HomeContentPage(),    
    ProfilePage(),
    ConfigPage(),
    CompararPage(),
  ];

  final List<String> _titles = [
    'Inicio',
    'Configuración',
    'Comparar Personajes',
    'Favoritos',
  ];

  void _onItemTapped(int index) {
    Navigator.pop(context);
    setState(() {
      _selectedIndex = index;
    });
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
            /*stTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () => _onItemTapped(1),
            ),*/
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
