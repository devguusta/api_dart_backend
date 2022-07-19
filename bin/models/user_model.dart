// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActived;
  DateTime? dtCreated;
  DateTime? dtUpdated;
  UserModel.create(
    this.id,
    this.name,
    this.email,
    this.isActived,
    this.dtCreated,
    this.dtUpdated,
  );

  UserModel();

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    bool? isActived,
    DateTime? dtCreated,
    DateTime? dtUpdated,
  }) {
    return UserModel.create(
      id ?? this.id,
      name ?? this.name,
      email ?? this.email,
      isActived ?? this.isActived,
      dtCreated ?? this.dtCreated,
      dtUpdated ?? this.dtUpdated,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
        map['id'] as int,
        map['nome'] as String,
        map['email'] as String,
        map['is_ativo'] as int == 1 ? true : false,
        map['dt_criacao'],
        map['dt_autalizacao']);
  }

  factory UserModel.fromRequest(Map<String, dynamic> map) {
    return UserModel()
      ..name = map['name']
      ..email = map['email']
      ..password = map['password'];
  }

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
