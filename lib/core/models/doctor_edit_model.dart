// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DoctorEditModel {
  String id;
  String doctorname;
  String specialization;
  String about;
  String phone;
  String gender;
  String experience;
  List<String> workday;
  DoctorEditModel({
    required this.id,
    required this.doctorname,
    required this.specialization,
    required this.about,
    required this.phone,
    required this.gender,
    required this.experience,
    required this.workday,
  });

  DoctorEditModel copyWith({
    String? id,
    String? doctorname,
    String? specialization,
    String? about,
    String? phone,
    String? gender,
    String? experience,
    List<String>? workday,
  }) {
    return DoctorEditModel(
      id: id ?? this.id,
      doctorname: doctorname ?? this.doctorname,
      specialization: specialization ?? this.specialization,
      about: about ?? this.about,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      experience: experience ?? this.experience,
      workday: workday ?? this.workday,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'doctorname': doctorname,
      'specialization': specialization,
      'about': about,
      'phone': phone,
      'gender': gender,
      'experience': experience,
      'workday': workday,
    };
  }

  factory DoctorEditModel.fromMap(Map<String, dynamic> map) {
    return DoctorEditModel(
      id: map['id'] as String,
      doctorname: map['doctorname'] as String,
      specialization: map['specialization'] as String,
      about: map['about'] as String,
      phone: map['phone'] as String,
      gender: map['gender'] as String,
      experience: map['experience'] as String,
      workday: List<String>.from((map['workday'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory DoctorEditModel.fromJson(String source) => DoctorEditModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorEditModel(id: $id, doctorname: $doctorname, specialization: $specialization, about: $about, phone: $phone, gender: $gender, experience: $experience, workday: $workday)';
  }

  @override
  bool operator ==(covariant DoctorEditModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.doctorname == doctorname &&
      other.specialization == specialization &&
      other.about == about &&
      other.phone == phone &&
      other.gender == gender &&
      other.experience == experience &&
      listEquals(other.workday, workday);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      doctorname.hashCode ^
      specialization.hashCode ^
      about.hashCode ^
      phone.hashCode ^
      gender.hashCode ^
      experience.hashCode ^
      workday.hashCode;
  }
}
