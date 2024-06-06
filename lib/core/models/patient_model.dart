// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PatientModel {
  String username;
  String useremail;
  String gender;
  String phone;
  String image;
  int id;
  PatientModel({
    required this.username,
    required this.useremail,
    required this.gender,
    required this.phone,
    required this.image,
    required this.id,
  });

  PatientModel copyWith({
    String? username,
    String? useremail,
    String? gender,
    String? phone,
    String? image,
    int? id,
  }) {
    return PatientModel(
      username: username ?? this.username,
      useremail: useremail ?? this.useremail,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'useremail': useremail,
      'gender': gender,
      'phone': phone,
      'image': image,
      'id': id,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      username: map['username'] as String,
      useremail: map['useremail'] as String,
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      image: map['image'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PatientModel(username: $username, useremail: $useremail, gender: $gender, phone: $phone, image: $image, id: $id)';
  }

  @override
  bool operator ==(covariant PatientModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.useremail == useremail &&
        other.gender == gender &&
        other.phone == phone &&
        other.image == image &&
        other.id == id;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        useremail.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        id.hashCode;
  }
}
