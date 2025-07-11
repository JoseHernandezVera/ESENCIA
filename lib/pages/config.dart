import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text("Tema oscuro"),
            value: settings.themeMode == ThemeMode.dark,
            onChanged: (value) => context.read<SettingsProvider>().toggleTheme(value),
          ),
          const SizedBox(height: 20),
          Text("Cards por fila:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3].map((count) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text('$count'),
                  selected: settings.cardsPerRow == count,
                  onSelected: (_) => context.read<SettingsProvider>().updateCardsPerRow(count),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
