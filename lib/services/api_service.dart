import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person.dart';
import '../models/person_image.dart';

class ApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '2dfe23358236069710a379edd4c65a6b';

  Future<List<Person>> getFamousPersons() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/person/popular?api_key=$_apiKey'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Person.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load persons');
      }
    } catch (e) {
      throw Exception('Error fetching persons: $e');
    }
  }

  Future<Person> getPersonDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/person/$id?api_key=$_apiKey'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Person.fromJson(data);
      } else {
        throw Exception('Failed to load person details');
      }
    } catch (e) {
      throw Exception('Error fetching person details: $e');
    }
  }

  Future<List<PersonImage>> getPersonImages(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/person/$id/images?api_key=$_apiKey'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> profiles = data['profiles'];
        return profiles.map((json) => PersonImage.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load person images');
      }
    } catch (e) {
      throw Exception('Error fetching person images: $e');
    }
  }
} 