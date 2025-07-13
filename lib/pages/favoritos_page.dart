import 'package:share_plus/share_plus.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_services.dart';
import '../services/naruto_character.dart';
import '../providers/favorites_provider.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<NarutoCharacter> _all = [];

  @override
  void initState() {
    super.initState();
    ApiService.fetchCharacters(limit: 637).then((list) {
      if (mounted) {
        setState(() => _all = list);
      }
    });
  }

  void _shareFavorites(List<NarutoCharacter> favoritos) {
    if (favoritos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tienes favoritos para compartir.')),
      );
      return;
    }

    final String header = 'Mis Personajes Favoritos de la app ESENCIA:\n\n';
    final String charactersList = favoritos.map((c) => '- ${c.name}').join('\n');
    final String fullText = header + charactersList;

    Share.share(fullText, subject: 'Mis Personajes Favoritos de ESENCIA');
  }

  @override
  Widget build(BuildContext context) {
    final favs = context.watch<FavoritesProvider>().favorites;
    final favoritos = _all.where((c) => favs.contains(c.name)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              _shareFavorites(favoritos);
            },
            tooltip: 'Compartir Favoritos',
          ),
        ],
      ),
      body: favoritos.isEmpty
          ? const Center(child: Text('No tienes personajes favoritos aún.'))
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final c = favoritos[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(c.image),
                  ),
                  title: Text(c.name),
                  subtitle: Text('Clan: ${c.clan}\nNaturaleza: ${c.nature}'),
                  isThreeLine: true,
                );
              },
            ),
    );
  }

}
