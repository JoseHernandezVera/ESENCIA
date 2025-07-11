import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../services/naruto_character.dart';
import '../models/clan.dart';
import '../models/village.dart';
import '../models/akatsuki.dart';
import '../models/kekkei_genkai.dart';
import '../models/tailed_beast.dart';
import '../models/team.dart';

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
  int _currentPage = 1;
  final int _itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _loadCollection();
    _scrollController.addListener(_scrollListener);
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

      final newItems = moreItems.where((item) =>
        !_allItems.any((existing) => existing.name == item.name)).toList();

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
        return await ApiService.fetchCharacters(name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.clans:
        return await ApiService.fetchClans(name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.villages:
        return await ApiService.fetchVillages(name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.akatsuki:
        return await ApiService.fetchAkatsuki(name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.kekkeiGenkai:
        return await ApiService.fetchKekkeiGenkai(name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.tailedBeasts:
        return await ApiService.fetchTailedBeasts(name: _searchQuery, page: page, limit: _itemsPerPage);
      case CollectionType.teams:
        return await ApiService.fetchTeams(name: _searchQuery, page: page, limit: _itemsPerPage);
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: DropdownButton<CollectionType>(
            isExpanded: true,
            value: _selectedCollection,
            items: CollectionType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  _getCollectionName(type),
                  style: Theme.of(context).textTheme.titleMedium,
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
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar por nombre...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
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
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Error al cargar los datos',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
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
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 48),
                      SizedBox(height: 16),
                      Text('No se encontraron resultados'),
                    ],
                  ),
                );
              }

              final items = snapshot.data!;
              return RefreshIndicator(
                onRefresh: _loadCollection,
                child: GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: items.length + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= items.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return _buildCardForItem(items[index]);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCardForItem(dynamic item) {
    String name = '';
    String description = '';
    String image = '';

    if (item is NarutoCharacter) {
      name = item.name;
      description = 'Debut: ${item.debut}\nClan: ${item.clan}';
      image = item.image;
    } else if (item is Clan ||
        item is Village ||
        item is AkatsukiMember ||
        item is KekkeiGenkai ||
        item is TailedBeast ||
        item is Team) {
      name = item.name;
      description = item.description;
      image = item.image;
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: image.isNotEmpty
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
                    ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}