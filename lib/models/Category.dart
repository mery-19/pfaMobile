class Category {
  final int id;
  final String libele;
  final String image;
  
  Category({this.id,
  this.libele,
  this.image,
});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id:json['id'],
      libele:json['libele'],
      image:json['image'],
    );
  }
}