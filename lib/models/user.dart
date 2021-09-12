class User {
  final String? id;
  final String name;
  final String email;
  String avatarUrl = "";

  User({
    this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });
}
