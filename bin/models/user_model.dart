// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String email;
  final bool isActived;
  final DateTime dtCreated;
  final DateTime dtUpdated;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActived,
    required this.dtCreated,
    required this.dtUpdated,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    bool? isActived,
    DateTime? dtCreated,
    DateTime? dtUpdated,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isActived: isActived ?? this.isActived,
      dtCreated: dtCreated ?? this.dtCreated,
      dtUpdated: dtUpdated ?? this.dtUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'isActived': isActived,
      'dtCreated': dtCreated.millisecondsSinceEpoch,
      'dtUpdated': dtUpdated.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] as int,
        name: map['nome'] as String,
        email: map['email'] as String,
        isActived: map['is_ativo'] as int == 1 ? true : false,
        dtCreated: map['dt_criacao'],
        dtUpdated: map['dt_autalizacao']);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isActived: $isActived, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.isActived == isActived &&
        other.dtCreated == dtCreated &&
        other.dtUpdated == dtUpdated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        isActived.hashCode ^
        dtCreated.hashCode ^
        dtUpdated.hashCode;
  }
}
