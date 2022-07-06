// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime dtCreated;
  final DateTime? dtUpdated;
  NewsModel({
    required this.id,
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
}
