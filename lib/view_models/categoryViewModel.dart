import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/category.dart';

class CategoryViewModel extends ChangeNotifier{
  List<Category> categoryList = [];

  Future<List<Category>> fetchCategory() async {
    String url = Constant.categoryListUrl;
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    print(response.body);
    List<dynamic> category_list_dynamic = result.map((i) => Category.fromJson(i)).toList();
    List<Category> category_list = new List<Category>();
    for(int i = 0; i < category_list_dynamic.length ; i ++){
      category_list.add(category_list_dynamic[i]);
    }
    print(category_list[0].id);
    this.categoryList = category_list;
    print("Category Fetched");
    notifyListeners();
  }

  Future<List<Category>> getCategory() async {
    await this.fetchCategory();
    return this.categoryList;
  }

  Category getCategoryById(id) {
    for(int i = 0; i < this.categoryList.length ; i++){
      if(id == this.categoryList[i].id){
        return this.categoryList[i];
      }
    }
    return null;
  }


}