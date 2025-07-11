import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../services/naruto_character.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  late Future<List<NarutoCharacter>> _futureCharacters;
  List<NarutoCharacter> _allCharacters = [];
  List<NarutoCharacter> _filteredCharacters = [];
  List<bool> _isExpandedList = [];

  @override
  void initState() {
    super.initState();
    _futureCharacters = ApiService.fetchCharacters().then((characters) {
      _allCharacters = characters;
      _filteredCharacters = characters;
      _isExpandedList = List<bool>.filled(characters.length, false);
      return characters;
    });
  }

  void _filterCharacters(String query) {
    setState(() {
      
      _filteredCharacters = _allCharacters
          .where((character) =>
              character.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NarutoCharacter>>(
      future: _futureCharacters,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No se encontraron personajes.'));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar personaje',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: _filterCharacters,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _filteredCharacters.length,
                  itemBuilder: (context, index) {
                    final char = _filteredCharacters[index];
                    final expanded = index < _isExpandedList.length
                        ? _isExpandedList[index]
                        : false;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpandedList[index] = !expanded;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 6,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  char.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(child: Icon(Icons.error)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: expanded ? 8 : 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        char.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('Debut: ${char.debut}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      Text('Clan: ${char.clan}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      if (expanded) ...[
                                        const SizedBox(height: 8),
                                        Text('Sexo: ${char.gender}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        Text('Altura: ${char.height}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        Text('Afiliaciones: ${char.affiliation}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        Text('Naturaleza del chakra: ${char.nature}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
