class UserProfile {
  final String id;
  final String? email;
  final String? name;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;

  UserProfile({
    required this.id,
    this.email,
    this.name,
    this.age,
    this.gender,
    this.height,
    this.weight,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
    };
  }
}
