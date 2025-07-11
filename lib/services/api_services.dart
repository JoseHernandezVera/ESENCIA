import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'naruto_character.dart';
import '../models/clan.dart';
import '../models/village.dart';
import '../models/akatsuki.dart';
import '../models/kekkei_genkai.dart';
import '../models/tailed_beast.dart';
import '../models/team.dart';

class ApiService {
  static const String baseUrl = 'https://dattebayo-api.onrender.com';
  static const Duration timeoutDuration = Duration(seconds: 15);

  static Future<List<T>> _fetchList<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String name = '',
    int page = 1,
    int limit = 637,
  }) async {
    try {
      final params = {
        if (name.isNotEmpty) 'name': name,
        'page': page.toString(),
        'limit': limit.toString(),
      };

      final url = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: params);
      print('[API Request] $url');

      final response = await http.get(url).timeout(timeoutDuration);

      if (response.statusCode != 200) {
        throw ApiException(
          'Error HTTP ${response.statusCode}',
          url: url.toString(),
          statusCode: response.statusCode,
        );
      }

      final decoded = json.decode(response.body);
      List<dynamic> items = [];

      if (decoded is List) {
        items = decoded;
      } 
      else if (decoded is Map && decoded.containsKey('items')) {
        items = decoded['items'] as List;
      }
      else if (decoded is Map && decoded.isNotEmpty && decoded.values.first is List) {
        items = decoded.values.first as List;
      }
      else if (decoded is Map) {
        items = [decoded];
      }
      else {
        throw FormatException('Formato de respuesta no reconocido', response.body);
      }

      return items.map((item) {
        try {
          final itemMap = item as Map<String, dynamic>;

          if (!itemMap.containsKey('image') && itemMap.containsKey('images')) {
            final images = itemMap['images'];
            if (images is List && images.isNotEmpty) {
              itemMap['image'] = images.first;
            }
          }

          return fromJson(itemMap);
        } catch (e) {
          throw FormatException('Error al convertir item: ${e.toString()}', item);
        }
      }).toList();

    } on TimeoutException catch (_) {
      throw ApiException('Tiempo de espera agotado');
    } on http.ClientException catch (e) {
      throw ApiException('Error de conexión: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Error en el formato de los datos: ${e.message}');
    } catch (e) {
      throw ApiException('Error inesperado: ${e.toString()}');
    }
  }

  static Future<List<NarutoCharacter>> fetchCharacters({String name = '', int page = 1, int limit = 20}) =>
      _fetchList('characters', NarutoCharacter.fromJson, name: name, page: page, limit: limit);

  static Future<List<Clan>> fetchClans({String name = '', int page = 1, int limit = 20}) =>
      _fetchList('clans', Clan.fromJson, name: name, page: page, limit: limit);

  static Future<List<Village>> fetchVillages({String name = '', int page = 1, int limit = 20}) =>
      _fetchList('villages', Village.fromJson, name: name, page: page, limit: limit);

  static Future<List<AkatsukiMember>> fetchAkatsuki({String name = '', int page = 1, int limit = 20}) =>
      _fetchList('akatsuki', AkatsukiMember.fromJson, name: name, page: page, limit: limit);

  static Future<List<KekkeiGenkai>> fetchKekkeiGenkai({String name = '', int page = 1, int limit = 20}) =>
      _fetchList('kekkei-genkai', KekkeiGenkai.fromJson, name: name, page: page, limit: limit);

  static Future<List<TailedBeast>> fetchTailedBeasts({String name = '', int page = 1, int limit = 20}) =>
      _fetchList('tailed-beasts', TailedBeast.fromJson, name: name, page: page, limit: limit);

  static Future<List<Team>> fetchTeams({String name = '', int page = 1, int limit = 20}) =>
      _fetchList('teams', Team.fromJson, name: name, page: page, limit: limit);
}

class ApiException implements Exception {
  final String message;
  final String? url;
  final int? statusCode;

  ApiException(this.message, {this.url, this.statusCode});

  @override
  String toString() => 'ApiException: $message'
      '${url != null ? ' (URL: $url)' : ''}'
      '${statusCode != null ? ' [Status: $statusCode]' : ''}';
}
