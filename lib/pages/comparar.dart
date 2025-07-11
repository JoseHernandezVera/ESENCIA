import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../services/naruto_character.dart';

class CompararPage extends StatefulWidget {
  const CompararPage({super.key});

  @override
  State<CompararPage> createState() => _CompararPageState();
}

class _CompararPageState extends State<CompararPage> {
  List<NarutoCharacter> _allCharacters = [];
  NarutoCharacter? _selectedLeft;
  NarutoCharacter? _selectedRight;

  @override
  void initState() {
    super.initState();
    ApiService.fetchCharacters(limit: 637).then((characters) {
      setState(() {
        _allCharacters = characters;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _allCharacters.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Row(
            children: [
              Expanded(child: _buildCharacterSelector(true)),
              Container(
                width: 1,
                height: double.infinity,
                color: Colors.grey.shade400,
              ),
              Expanded(child: _buildCharacterSelector(false)),
            ],
          );
  }

  Widget _buildCharacterSelector(bool isLeft) {
    final selectedCharacter = isLeft ? _selectedLeft : _selectedRight;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Autocomplete<NarutoCharacter>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<NarutoCharacter>.empty();
              }
              return _allCharacters.where((char) =>
                  char.name.toLowerCase().contains(textEditingValue.text.toLowerCase()));
            },
            displayStringForOption: (char) => char.name,
            onSelected: (char) {
              setState(() {
                if (isLeft) {
                  _selectedLeft = char;
                } else {
                  _selectedRight = char;
                }
              });
            },
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'Buscar personaje',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          if (selectedCharacter != null) ...[
            Expanded(child: _buildCharacterCard(selectedCharacter)),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  if (isLeft) {
                    _selectedLeft = null;
                  } else {
                    _selectedRight = null;
                  }
                });
              },
              icon: const Icon(Icons.clear),
              label: const Text('Limpiar'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCharacterCard(NarutoCharacter char) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                char.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(char.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          _infoRow('Debut', char.debut),
          _infoRow('Clan', char.clan),
          _infoRow('Sexo', char.gender),
          _infoRow('Altura', char.height),
          _infoRow('Afiliaciones', char.affiliation),
          _infoRow('Naturaleza', char.nature),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
