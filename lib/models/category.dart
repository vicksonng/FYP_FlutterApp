class Category{
  int id;
  String categoryName;
  String categoryImgPath;
  String productType;

  Category({this.id, this.categoryName, this.categoryImgPath, this.productType});

  factory Category.fromJson(Map<String, dynamic> json) {
    return new Category(
        id: json['id'],
        categoryName: json['categoryName'],
        categoryImgPath: json['categoryImgPath'],
        productType: json['productType'],
    );
  }
}