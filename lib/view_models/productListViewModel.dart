import 'package:flutter/cupertino.dart';
import 'package:untitled/view_models/productViewModel.dart';
import 'package:untitled/webServices.dart';

class ProductListViewModel extends ChangeNotifier{
  List<ProductViewModel> products = List<ProductViewModel>();
  Future<void> fetchProducts() async {
    final results =  await WebService().fetchProducts();
    this.products = results.map((item) => ProductViewModel(product: item)).toList();
    print(this.products);
    notifyListeners();
  }
}