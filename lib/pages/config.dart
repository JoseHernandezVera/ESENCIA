import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: const Text("Tema oscuro"),
            value: settings.themeMode == ThemeMode.dark,
            onChanged: (value) =>
                context.read<SettingsProvider>().toggleTheme(value),
          ),
          const SizedBox(height: 20),
          Text(
            "Cards por fila:",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3].map((count) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text('$count'),
                  selected: settings.cardsPerRow == count,
                  onSelected: (_) =>
                      context.read<SettingsProvider>().updateCardsPerRow(count),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          Divider(thickness: 1),
          const SizedBox(height: 20),
          Text(
            "Sobre mí",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          const Text(
            "Nombre de la App:\nESENCIA\n",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "¿De qué trata?\nEsta aplicación permite explorar personajes y más del universo Naruto, con información detallada provista por la API de Dattebayo.",
          ),
          const SizedBox(height: 10),
          const Text(
            "Desarrolladores:\n- José Hernández\n- Fabian Arévalo",
          ),
          const SizedBox(height: 10),
          const Text(
            "Créditos API:\nDatos proporcionados por la comunidad de la API de Naruto:\nDattebayo API - https://dattebayo-api.onrender.com",
          ),
        ],
      ),
    );
  }
}
