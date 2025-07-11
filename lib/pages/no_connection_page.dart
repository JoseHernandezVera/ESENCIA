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
        const SnackBar(
          content: Text('Aún no hay conexión a Internet'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 20),
              Text(
                'Sin conexión a Internet',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Por favor, revisa tu conexión a la red y vuelve a intentarlo.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => _tryAgain(context),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}