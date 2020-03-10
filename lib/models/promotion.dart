class Promotion {
  int id;
  String promotionName;
  String promotionDesc;
  String promotionImgURL;
  String promotionStartDate;
  String promotionEndDate;
  Promotion({this.id, this.promotionName, this.promotionDesc, this.promotionImgURL, this.promotionStartDate, this.promotionEndDate});

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return new Promotion(
        id: json['id'],
        promotionName: json['promotionName'],
        promotionDesc: json['promotionDesc'],
        promotionImgURL: json['promotionImgURL'],
        promotionStartDate: json['promotionStartDate'],
        promotionEndDate: json['promotionEndDate'],
    );
  }

}