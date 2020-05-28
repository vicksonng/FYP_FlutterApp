import 'package:untitled/models/product.dart';
import 'package:untitled/models/salesBuyXGetY.dart';
import 'package:untitled/models/salesDiscount.dart';
import 'package:untitled/models/salesDiscountRate.dart';
import 'package:untitled/models/salesSpecialPrice.dart';
class CartItem{
  final product;
  int qty;
  double subTotal;
  List<SalesBuyXGetY> selectedSalesBuyXGetYList= [];
  List<SalesDiscount> selectedSalesDiscountList = [];
  List<SalesDiscountRate> selectedSalesDiscountRateList = [];
  List<SalesSpecialPrice> selectedSalesSpecialPriceList = [];


  CartItem(this.product, this.qty);

  Map<String, dynamic> toJson() =>
      {
        'product': product,
        'qty' : qty
      };

  calSubTotal() {
    print("ProductName:" + this.product.productName);
    print("qty " + qty.toString());
    var subTotal = this.product.currentPrice * this.qty.toDouble();
    print("SubTotal = " + subTotal.toString());
    if(this.selectedSalesBuyXGetYList.length > 0){
      for(int i = 0 ; i < this.selectedSalesBuyXGetYList.length ; i ++){
        subTotal = this.selectedSalesBuyXGetYList[i].calPrice(this.qty, subTotal);
        print("XY :" + subTotal.toString());
      }
    }
    if(this.selectedSalesDiscountList.length>0){
      for(int i = 0 ; i < this.selectedSalesDiscountList.length ;  i ++){
        subTotal = this.selectedSalesDiscountList[i].calPrice(this.qty, subTotal);
        print("Discount :" + subTotal.toString());
      }
    }
    if(this.selectedSalesDiscountRateList.length>0){
      for(int i = 0 ; i < this.selectedSalesDiscountRateList.length ;  i ++){
        subTotal = this.selectedSalesDiscountRateList[i].calPrice(this.qty, subTotal);
        print("DiscountRate :" + subTotal.toString());
      }
    }
    if(this.selectedSalesSpecialPriceList.length>0){
      for(int i = 0 ; i < this.selectedSalesSpecialPriceList.length ;  i ++){
        subTotal = this.selectedSalesSpecialPriceList[i].calPrice(this.qty, subTotal, this.product.currentPrice.toDouble());
        print("SpecialPrice :" + subTotal.toString());
      }
    }
    this.subTotal = subTotal;
    print("SubTotal after sales: "+ this.subTotal.toString());
    return this.subTotal;
  }
  double getSubTotal() {
    return this.subTotal;
  }

  int addSalesBuyXGetY(SalesBuyXGetY salesBuyXGetY){

    bool isAdded = false;
    for(int i = 0 ; i < this.selectedSalesBuyXGetYList.length ; i ++){
      if(this.selectedSalesBuyXGetYList[i].id == salesBuyXGetY.id){
        print(this.selectedSalesBuyXGetYList[i].id.toString() + " vs " + salesBuyXGetY.id.toString());
        isAdded = true;
        return 1;
      }
    }
    if(!isAdded){
      if(salesBuyXGetY.restrictedOne){
        if(this.isEmpty()){
          this.selectedSalesBuyXGetYList.add(salesBuyXGetY);
          return 2;
        }else{
          return 0;
        }
      }else {
        if(!this.isRestricted()){
          this.selectedSalesBuyXGetYList.add(salesBuyXGetY);
          return 2;
        }else {
          return 0;
        }

      }

    }

  }

  removeSalesBuyXGetY(SalesBuyXGetY salesBuyXGetY){
    for(int i = 0 ; i < this.selectedSalesBuyXGetYList.length ; i ++){
      if(salesBuyXGetY.id == this.selectedSalesBuyXGetYList[i].id){
        this.selectedSalesBuyXGetYList.removeAt(i);
        print("REMOVE BUYXGETY");
      }
    }
  }

  addSalesDiscount(SalesDiscount salesDiscount){
    bool isAdded = false;
    for(int i = 0 ; i < this.selectedSalesDiscountList.length ; i ++){
      if(this.selectedSalesDiscountList[i].id == salesDiscount.id){
        isAdded = true;
        return 1;
      }
    }
    if(!isAdded){
      if(salesDiscount.restrictedOne){
        if(this.isEmpty()){
          this.selectedSalesDiscountList.add(salesDiscount);
          return 2;
        }else {
          return 0;
        }
      }else{
        if(!this.isRestricted()){
          this.selectedSalesDiscountList.add(salesDiscount);
          return 2;
        }else{
          return 0;
        }


      }
      return 2;
    }

  }

  removeSalesDiscount(SalesDiscount salesDiscount){
    for(int i = 0 ; i < this.selectedSalesDiscountList.length ; i ++){
      if(salesDiscount.id == this.selectedSalesDiscountList[i].id){
        this.selectedSalesDiscountList.removeAt(i);
        print("REMOVE DISCOUNT");
      }
    }
  }


  addSalesDiscountRate(SalesDiscountRate salesDiscountRate){
    bool isAdded = false;
    for(int i = 0 ; i < this.selectedSalesDiscountRateList.length ; i ++){
      if(this.selectedSalesDiscountRateList[i].id == salesDiscountRate.id){
        isAdded = true;
        return 1;
      }
    }
    if(!isAdded){
      if(salesDiscountRate.restrictedOne){
        if(this.isEmpty()){
          this.selectedSalesDiscountRateList.add(salesDiscountRate);
          return 2;
        } else {
          return 0;
        }
      }else{
        if(!this.isRestricted()){
          this.selectedSalesDiscountRateList.add(salesDiscountRate);
          return 2;
        }else{
          return 0;
        }
      }
    }

  }

  removeSalesDiscountRate(SalesDiscountRate salesDiscountRate){
    for(int i = 0 ; i < this.selectedSalesDiscountRateList.length ; i ++){
      if(salesDiscountRate.id == this.selectedSalesDiscountRateList[i].id){
        this.selectedSalesDiscountRateList.removeAt(i);
        print("REMOVE DISCOUNTRATE");
      }
    }
  }

  addSalesSpecialPrice(SalesSpecialPrice salesSpecialPrice){

    bool isAdded = false;
    for(int i = 0 ; i < this.selectedSalesSpecialPriceList.length ; i ++){
      if(this.selectedSalesSpecialPriceList[i].id == salesSpecialPrice.id){
        isAdded = true;
        return 1;
      }
    }
    if(!isAdded){
      if(salesSpecialPrice.restrictedOne){
        if(this.isEmpty()){
          this.selectedSalesSpecialPriceList.add(salesSpecialPrice);
          return 2;
        }else {
          return 0;
        }
      }else {
        if(!this.isRestricted()){
          this.selectedSalesSpecialPriceList.add(salesSpecialPrice);
          return 2;
        }else {
          return 0;
        }

      }

    }
  }
  removeSpecialPrice(SalesSpecialPrice salesSpecialPrice){
    for(int i = 0 ; i < this.selectedSalesSpecialPriceList.length ; i ++){
      if(salesSpecialPrice.id == this.selectedSalesSpecialPriceList[i].id){
        this.selectedSalesSpecialPriceList.removeAt(i);
        print("REMOVE Special PRice");
      }
    }
  }
  void clearSales(){
    this.selectedSalesDiscountList = [];
    this.selectedSalesBuyXGetYList = [];
    this.selectedSalesSpecialPriceList = [];
    this.selectedSalesDiscountRateList = [];
    for(int i = 0 ; i < this.product.salesBuyXGetYList.length ; i++){
      this.product.salesBuyXGetYList[i].isSelected = false;
    }
    for(int i = 0 ; i < this.product.salesDiscountList.length ; i++){
      this.product.salesDiscountList[i].isSelected = false;
    }
    for(int i = 0 ; i < this.product.salesDiscountRateList.length ; i++){
      this.product.salesDiscountRateList[i].isSelected = false;
    }
    for(int i = 0 ; i < this.product.salesSpecialPriceList.length ; i++){
      this.product.salesSpecialPriceList[i].isSelected = false;
    }
    this.calSubTotal();
    print("After clear Sales, SubTotal is " + this.subTotal.toString());
  }

  bool isRestricted(){
    print("isRestricted????");
    for(int i = 0 ; i < this.selectedSalesDiscountRateList.length ; i ++){
      if(this.selectedSalesDiscountRateList[i].restrictedOne){
        return true;
      }
    }
    for(int i = 0 ; i < this.selectedSalesBuyXGetYList.length ; i ++){
      if(this.selectedSalesBuyXGetYList[i].restrictedOne){
        return true;
      }
    }
    for(int i = 0 ; i < this.selectedSalesDiscountList.length ; i ++){
      if(this.selectedSalesDiscountList[i].restrictedOne){
        return true;
      }
    }
    for(int i = 0 ; i < this.selectedSalesSpecialPriceList.length ; i ++){
      if(this.selectedSalesSpecialPriceList[i].restrictedOne){
        return true;
      }
    }
    print("isRestricted = false");
    return false;
  }

  bool isEmpty(){
    if(this.selectedSalesSpecialPriceList.length > 0 ||
    this.selectedSalesBuyXGetYList.length >  0 ||
    this.selectedSalesDiscountList.length > 0 ||
    this.selectedSalesDiscountRateList.length > 0 ){
      return false;
    }
    return true;
  }

  bool haveSales(){
    if(this.product.salesBuyXGetYList.length > 0 ||this.product.salesDiscountList.length > 0 || this.product.salesSpecialPriceList.length > 0 || this.product.salesSpecialPriceList.length > 0 ){
      return true;
    }else{
      return false;
    }
  }
}