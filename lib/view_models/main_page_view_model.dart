import 'package:scoped_model/scoped_model.dart';
import 'package:untitled/models/product.dart';

class MainPageViewModel extends Model{
  Future<List<Product>> _products;
//  Future<List<Product>> getProducts(){
//    return _products;
//  }
//
//  setProducts(Future<List<Product>> value) {
//    this._products = value;
//    notifyListeners();
//
//  }




  Future<List<Product>> get products => _products;
  set products(Future<List<Product>> value) {
      _products = value;
      notifyListeners();
    }





}