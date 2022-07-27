import 'dart:convert';

class AuthTo {
  final String email;
  final String password;
  AuthTo({
    required this.email,
    required this.password,
  });

  AuthTo copyWith({
    String? email,
    String? password,
  }) {
    return AuthTo(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory AuthTo.fromRequest(String body) {
    var map = jsonDecode(body);
    return AuthTo(email: map['email'], password: map['password']);
  }

  factory AuthTo.fromMap(Map<String, dynamic> map) {
    return AuthTo(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthTo.fromJson(String source) =>
      AuthTo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserTo(email: $email, password: $password)';

  @override
  bool operator ==(covariant AuthTo other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
