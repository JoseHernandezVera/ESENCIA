import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../services/naruto_character.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<NarutoCharacter>> _futureCharacters;

  @override
  void initState() {
    super.initState();
    _futureCharacters = ApiService.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes de Naruto'),
      ),
      body: FutureBuilder<List<NarutoCharacter>>(
        future: _futureCharacters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron personajes.'));
          }

          final characters = snapshot.data!;
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final char = characters[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                elevation: 2,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      char.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error_outline),
                    ),
                  ),
                  title: Text(
                    char.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text('Debut en anime: ${char.debut}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
