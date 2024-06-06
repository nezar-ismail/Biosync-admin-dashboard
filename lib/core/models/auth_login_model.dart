import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AuthLoginModel {
  String? token;
  String? email;
  AuthLoginModel({
    this.token,
    this.email,
  });

  AuthLoginModel copyWith({
    String? token,
    String? email,
  }) {
    return AuthLoginModel(
      token: token ?? this.token,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'email': email,
    };
  }

  factory AuthLoginModel.fromMap(Map<String, dynamic> map) {
    return AuthLoginModel(
      token: map['token'] != null ? map['token'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthLoginModel.fromJson(String source) =>
      AuthLoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthLoginModel(token: $token, email: $email)';

  @override
  bool operator ==(covariant AuthLoginModel other) {
    if (identical(this, other)) return true;

    return other.token == token && other.email == email;
  }

  @override
  int get hashCode => token.hashCode ^ email.hashCode;
}
