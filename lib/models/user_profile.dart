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

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      height: (map['height'] as num?)?.toDouble(),
      weight: (map['weight'] as num?)?.toDouble(),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      UserProfile.fromMap(json);

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
