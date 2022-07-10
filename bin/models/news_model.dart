import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final DateTime dtCreated;
  final DateTime? dtUpdated;
  NewsModel({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.dtCreated,
    this.dtUpdated,
  });

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, image: $image, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }

  Map toMap() {
    return {
      'id': id.toString(),
      'title': title,
      'description': description,
      'image': image,
      'dtCreated': dtCreated.millisecondsSinceEpoch,
      'dtUpdated': dtUpdated?.millisecondsSinceEpoch,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] ?? 0,
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      dtCreated: DateTime.fromMillisecondsSinceEpoch(map['dtCreated'] as int),
      dtUpdated: map['dtUpdated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dtUpdated'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
