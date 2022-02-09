class User {
  late String id;
  late String username;
  late String email;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String verified;
  late bool admin;

  User({
    required this.id,
    required this.username,
    required this.email,
    required String createdAt,
    required String updatedAt,
    required this.verified,
    required this.admin,
  }) {
    this.createdAt = DateTime.parse(createdAt);
    this.updatedAt = DateTime.parse(updatedAt);
  }
}
