import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'homepage.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  Future<bool> _checkConnection() async {
    final connectivity = Connectivity();
    try {
      final results = await connectivity.checkConnectivity();
      return results.isNotEmpty && results.any((result) => result != ConnectivityResult.none);
    } catch (e) {
      debugPrint('Error checking connection: $e');
      return false;
    }
  }

  Future<void> _tryAgain(BuildContext context) async {
    final hasConnection = await _checkConnection();
    
    if (!context.mounted) return;
    
    if (hasConnection) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Aún no hay conexión a Internet'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off, 
                size: 80, 
                color: colorScheme.error,
              ),
              const SizedBox(height: 20),
              Text(
                'Sin conexión a Internet',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Por favor, revisa tu conexión a la red y vuelve a intentarlo.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => _tryAgain(context),
                icon: Icon(Icons.refresh, color: colorScheme.onPrimary),
                label: Text(
                  'Reintentar',
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}