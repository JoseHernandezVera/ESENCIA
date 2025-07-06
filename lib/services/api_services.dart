import 'dart:convert';
import 'package:http/http.dart' as http;
import 'naruto_character.dart';

class ApiService {
  static const String baseUrl = 'https://dattebayo-api.onrender.com/characters';

  static Future<List<NarutoCharacter>> fetchCharacters() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> jsonList = jsonData['characters'];

      for (var item in jsonList.take(5)) {
        print('JSON personaje: $item\n');
      }
      return jsonList.map((json) => NarutoCharacter.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los personajes');
    }
  }
}
