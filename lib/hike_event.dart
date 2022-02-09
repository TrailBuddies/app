import 'package:trail_buddies/user.dart';

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
}
