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
      setState(() => _all = list);
    });
  }

  @override
  Widget build(BuildContext context) {
    final favs = context.watch<FavoritesProvider>().favorites;
    final favoritos = _all.where((c) => favs.contains(c.name)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
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
