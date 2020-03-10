import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled/models/product.dart';

class WebService {

  Future<List<Product>> fetchProducts() async{
    final url = 'http://localhost:1337/getAllProducts';
    final response = await http.get(url);
    if(response.statusCode == 200) {

      final body = jsonDecode(response.body);
      final Iterable json = body;
      return json.map((product) => Product.fromJson(product)).toList();

    } else {
      throw Exception("Unable to perform request!");
    }

  }

}