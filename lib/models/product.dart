class Product {
  int id;
  String productName;
  String picture;
  int oldPrice;
  int price;
  String benefits;
  String ingredients;

  Product(
      {this.id, this.productName, this.picture, this.oldPrice, this.price, this.benefits, this.ingredients}
      );

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        id: json['id'],
        productName: json['productName'],
        picture: json['imgURL'],
        oldPrice: json['oldPrice'],
        price: json['currentPrice'],
        benefits: json['benefits'],
        ingredients: json['ingredients']
    );
  }

}

//  Product.fromJson(Map<String, dynamic> map) {
//    productName = map['productName'];
//    picture = map['imgName'];
//    oldPrice = int.parse(map['oldPrice']);
//    price = int.parse(map['currentPrice']);
//    benefits = map['benefits'];
//    ingredients = map['ingredients'];
//  }