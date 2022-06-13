import 'dart:convert';

import 'package:http/http.dart';

import 'package:trail_buddies/user.dart';
import 'package:trail_buddies/declarations.dart';

class HikeEvent {
  late String id;
  late String title;
  late String description;
  late List<DateTime> duration;
  late double lat;
  late double lng;
  late int difficulty;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String imageUrl;
  late String userId;

  HikeEvent({
    required this.id,
    required this.title,
    required this.description,
    required String duration,
    required String lat,
    required String lng,
    required String difficulty,
    required String createdAt,
    required String updatedAt,
    required this.imageUrl,
    required this.userId,
  }) {
    this.duration =
        duration.split('...').map((d) => DateTime.parse(d)).toList();
    this.lat = double.parse(lat);
    this.lng = double.parse(lng);
    this.difficulty = int.parse(difficulty);
    this.createdAt = DateTime.parse(createdAt);
    this.updatedAt = DateTime.parse(updatedAt);
  }

  Future<User?> getUser() async {
    return await User.fetch(userId);
  }

  static Future<HikeEvent?> fetch(String id) async {
    final response = await get(
      Uri.parse('$baseUrl/api/v1/hike_events/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    if (json['error'] != null) {
      throw Exception(
          'Failed to fetch hike event $id. Response: ${json.toString()}');
    } else {
      return HikeEvent(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        duration: json['duration'],
        lat: json['lat'],
        lng: json['lng'],
        difficulty: json['difficulty'].toString(),
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        imageUrl: json['image_url'],
        userId: json['user_id'],
      );
    }
  }

  static Future<List<HikeEvent>> all() async {
    final response = await get(
      Uri.parse('$baseUrl/api/v1/hike_events'),
      headers: {'Content-Type': 'application/json'},
    );

    final json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(json['error'] ??
          'Failed to fetch /api/v1/hike_events. Failed with status ${response.statusCode} and response: ${json.toString()}');
    } else {
      return (json as List<dynamic>)
          .map((e) => HikeEvent(
                id: e['id'],
                title: e['title'],
                description: e['description'],
                duration: e['duration'],
                lat: e['lat'],
                lng: e['lng'],
                difficulty: e['difficulty'].toString(),
                createdAt: e['created_at'],
                updatedAt: e['updated_at'],
                imageUrl: e['image_url'],
                userId: e['user_id'],
              ))
          .toList();
    }
  }
}
