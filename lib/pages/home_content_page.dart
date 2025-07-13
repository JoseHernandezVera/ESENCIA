import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/favorites_provider.dart';
import '../services/api_services.dart';
import '../services/naruto_character.dart';
import '../models/clan.dart';
import '../models/village.dart';
import '../models/akatsuki.dart';
import '../models/kekkei_genkai.dart';
import '../models/tailed_beast.dart';
import '../models/team.dart';
import 'package:collection/collection.dart';

enum CollectionType {
  characters,
  clans,
  villages,
  akatsuki,
  kekkeiGenkai,
  tailedBeasts,
  teams,
}

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  CollectionType _selectedCollection = CollectionType.characters;
  String _searchQuery = '';
  late Future<List<dynamic>> _futureItems;
  final TextEditingController _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;
  List<dynamic> _allItems = [];
  List<NarutoCharacter> _allCharacters = [];
  int _currentPage = 1;
  final int _itemsPerPage = 30;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
    _loadCollection();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _loadCharacters() async {
    final characters = await ApiService.fetchCharacters(limit: 637);
    if (mounted) {
      setState(() {
        _allCharacters = characters;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      _loadMoreItems();
    }
  }

  Future<void> _loadCollection() async {
    setState(() {
      _isLoadingMore = true;
      _currentPage = 1;
      _allItems.clear();
    });

    try {
      final newItems = await _fetchCurrentCollection(page: _currentPage);
      setState(() {
        _allItems = newItems;
        _futureItems = Future.value(_allItems);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  Future<void> _loadMoreItems() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);
    _currentPage++;

    try {
      final moreItems = await _fetchCurrentCollection(page: _currentPage);

      final newItems = moreItems
          .where((item) =>
              !_allItems.any((existing) => existing.name == item.name))
          .toList();

      setState(() {
        _allItems.addAll(newItems);
        _futureItems = Future.value(_allItems);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar más items: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingMore = false);
      }
    }
  }

  Future<List<dynamic>> _fetchCurrentCollection({int page = 1}) async {
    switch (_selectedCollection) {
      case CollectionType.characters:
        return await ApiService.fetchCharacters(
            name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.clans:
        return await ApiService.fetchClans(
            name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.villages:
        return await ApiService.fetchVillages(
            name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.akatsuki:
        return await ApiService.fetchAkatsuki(
            name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.kekkeiGenkai:
        return await ApiService.fetchKekkeiGenkai(
            name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.tailedBeasts:
        return await ApiService.fetchTailedBeasts(
            name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.teams:
        return await ApiService.fetchTeams(
            name: _searchQuery, page: page, limit: _itemsPerPage);
    }
  }

  void _onSearchChanged(String value) {
    _searchQuery = value.trim();
    _loadCollection();
  }

  String _getCollectionName(CollectionType type) {
    switch (type) {
      case CollectionType.characters:
        return 'Personajes';
      case CollectionType.clans:
        return 'Clanes';
      case CollectionType.villages:
        return 'Aldeas';
      case CollectionType.akatsuki:
        return 'Akatsuki';
      case CollectionType.kekkeiGenkai:
        return 'Kekkei Genkai';
      case CollectionType.tailedBeasts:
        return 'Bestias con Cola';
      case CollectionType.teams:
        return 'Equipos';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/fondo.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white70),
                  color: Colors.black.withOpacity(0.9),
                ),
                child: DropdownButton<CollectionType>(
                  isExpanded: true,
                  value: _selectedCollection,
                  items: CollectionType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          _getCollectionName(type),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newType) {
                    if (newType != null) {
                      setState(() {
                        _selectedCollection = newType;
                        _searchController.clear();
                        _searchQuery = '';
                        _allItems = [];
                        _loadCollection();
                      });
                    }
                  },
                  dropdownColor: Colors.black.withOpacity(0.7),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  iconSize: 24,
                  underline: Container(),
                  style: TextStyle(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre...',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  fillColor: Colors.black.withOpacity(0.9),
                  filled: true,
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) => _onSearchChanged(value),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _futureItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      _allItems.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline,
                              size: 48, color: Colors.white),
                          const SizedBox(height: 16),
                          Text(
                            'Error al cargar los datos',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.error.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadCollection,
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 48, color: Colors.white),
                          const SizedBox(height: 16),
                          Text(
                            'No se encontraron resultados',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }

                  final items = snapshot.data!;
                  final cardsPerRow =
                      context.watch<SettingsProvider>().cardsPerRow;

                  return RefreshIndicator(
                    onRefresh: _loadCollection,
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cardsPerRow,
                        childAspectRatio: 535 / 100,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 1,
                      ),
                      itemCount: items.length + (_isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= items.length) {
                          return const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ));
                        }
                        return GestureDetector(
                          onTap: () => _showDetailModal(items[index]),
                          child: _buildCardForItem(items[index]),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardForItem(dynamic item) {
    String name = '';
    bool isCharacter = false;

    if (item is NarutoCharacter) {
      name = item.name;
      isCharacter = true;
    } else if (item is AkatsukiMember) {
      name = item.name;
    } else if (item is Clan) {
      name = item.name;
    } else if (item is Team) {
      name = item.name;
    } else if (item is KekkeiGenkai) {
      name = item.name;
    } else if (item is Village) {
      name = item.name;
    } else if (item is TailedBeast) {
      name = item.name;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      child: AspectRatio(
        aspectRatio: 535 / 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/pergaminocerrado.png',
              fit: BoxFit.fill,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailModal(dynamic item) {
    String name = '';
    String description = '';
    String image = '';
    List<String> chips = [];
    bool isCharacter = false;

    if (item is NarutoCharacter) {
      name = item.name;
      description =
          'Debut: ${item.debut}\nClan: ${item.clan}\nSexo: ${item.gender}\nAltura: ${item.height}\nAfiliación: ${item.affiliation}\nNaturaleza: ${item.nature}';
      image = item.image;
      isCharacter = true;
    } else if (item is AkatsukiMember) {
      name = item.name;
      final match = _allCharacters.firstWhereOrNull((c) => c.name == item.name);
      if (match != null) {
        description =
            'Debut: ${match.debut}\nClan: ${match.clan}\nSexo: ${match.gender}\nAltura: ${match.height}\nAfiliación: ${match.affiliation}\nNaturaleza: ${match.nature}';
        image = match.image;
        isCharacter = true;
      } else {
        description =
            '${item.description}\nEstado: ${item.status ?? "Desconocido"}\nHabilidades: ${item.abilities?.join(", ") ?? "N/A"}';
        image = item.image;
      }
    } else if (item is Clan) {
      name = item.name;
      description = item.description;
      chips = item.members ?? [];
      image = item.image;
    } else if (item is Team) {
      name = item.name;
      description = item.description;
      chips = item.members ?? [];
      image = item.image;
    } else if (item is KekkeiGenkai) {
      name = item.name;
      description = item.description;
      chips = item.users ?? [];
      image = item.image;
    } else if (item is Village) {
      name = item.name;
      description =
          '${item.description}\nPaís: ${item.country ?? "Desconocido"}\nLíder: ${item.leader ?? "Desconocido"}';
      image = item.image;
    } else if (item is TailedBeast) {
      name = item.name;
      description =
          '${item.description}\nColas: ${item.tails ?? "N/A"}\nJinchuriki: ${item.jinchuriki ?? "N/A"}';
      image = item.image;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              margin: const EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    'assets/images/pergaminoabierto.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 24,
                      right: 24,
                      bottom: 24,
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 0),
                              if (isCharacter || item is AkatsukiMember)
                                Consumer<FavoritesProvider>(
                                  builder: (context, favorites, _) {
                                    final isFav = favorites.isFavorite(name);
                                    return IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFav ? Colors.red : Colors.black,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        Provider.of<FavoritesProvider>(context,
                                                listen: false)
                                            .toggleFavorite(name);
                                      },
                                    );
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          if (image.isNotEmpty)
                            Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width * 0.5,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                          if (chips.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: chips
                                  .map((c) => Chip(
                                        label: Text(c),
                                        backgroundColor: Colors.brown[100],
                                      ))
                                  .toList(),
                            ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}