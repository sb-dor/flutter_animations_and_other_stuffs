class MemeModel {
  int? id;
  String? image;
  String? caption;
  String? category;

  MemeModel({
    this.id,
    this.image,
    this.caption,
    this.category,
  });

  MemeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        image = json['image'],
        caption = json['caption'],
        category = json['category'];
}
