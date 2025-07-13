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
            children: [1, 2].map((count) {
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
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.info_outline),
              label: const Text("Sobre mí"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/icons/SoloLogo.png',
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "ESENCIA",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "¿De qué trata?\nEsta aplicación permite explorar personajes y más del universo Naruto, con información detallada provista por la API de Dattebayo.",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Desarrolladores:\n- José Hernández\n- Fabián Arévalo",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Créditos API:\nDatos proporcionados por la comunidad de la API de Naruto:\nDattebayo API - https://dattebayo-api.onrender.com",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              child: const Text("Cerrar"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
