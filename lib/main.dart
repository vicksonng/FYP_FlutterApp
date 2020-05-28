import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view_models/cartListViewModel.dart';
import 'package:untitled/view_models/categoryViewModel.dart';
import 'package:untitled/view_models/promotionPageViewModel.dart';
import 'package:untitled/view_models/promotionViewModel.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/view_models/productListViewModel.dart';
import 'package:untitled/views/components/homePageCarousel.dart';


//import package here
import 'package:untitled/views/components/horizontal_list.dart';
import 'package:untitled/views/components/productsListComponent.dart';
import 'package:untitled/views/pages/categoriesPage.dart';
import 'package:untitled/views/pages/categoryPage.dart';
import 'package:untitled/views/pages/shoppingCartPage.dart';
import 'package:http/http.dart' as http;

import 'dialogflow/dialog_flow.dart';

void main() {
  runApp(
    MyApp()
  );
}
//Future<http.Response> fetchProducts() async {
//  return await http.get('http://localhost:1337/getAllProducts');
//}
//
//getProducts()  {
//  fetchProducts().then((response) {
//    print(jsonDecode(response.body));
//    List<dynamic> product_list = jsonDecode(response.body);
//    print(product_list.length);
//    return product_list;
//  });
//}


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => CartListViewModel()),
          ChangeNotifierProvider(builder: (_) => UserViewModel()),
          ChangeNotifierProvider(builder: (_) => ProductListViewModel()),
          ChangeNotifierProvider(builder: (_) => CategoryViewModel()),
          ChangeNotifierProvider(builder: (_) => PromotionPageViewModel()),
        ],
        child: MaterialApp(
            title: 'Hung Fook Tong',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage()
        )
    );
  }
}
//    return ChangeNotifierProvider<CartListViewModel> (
//      create: (context) => CartListViewModel(),
//      child: MaterialApp(
//          title: 'Hung Fook Tong',
//          theme: ThemeData(
//            primarySwatch: Colors.blue,
//          ),
//          home: HomePage()
//      )
//    );
//
//    return MaterialApp(
//      title: 'Hung Fook Tong',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: HomePage()
////    );
//  }
//}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Widget build(BuildContext context) {
//    Timer.periodic(Duration(seconds: 300), (timer) {
//      setState(() {
//      });
//    });

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Align(
          child: Padding(
            child: Text('鴻福堂Home+'),
            padding: EdgeInsets.all(5)
          ),
          alignment: Alignment.centerLeft,
        ),
        actions: <Widget>[
//          new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white,), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => new ShoppingCartPage()));
          })
        ],
      ),


        body: new ListView(
          children: <Widget>[
            //image Carousel Begins
            HomePageCarousel(),
//            image_carousel,
            //padding
            new Padding(padding: const EdgeInsets.all(8),
              child: new Text('服務列表'),),
            //Categories List
            HorizontalList(),
            new Padding(padding: const EdgeInsets.all(15),
              child: new Text('精選推薦'),
            ),

            Container(
              height: 400.0,
              child: ProductsListComponent('ALL'),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FlutterFactsChatBot()));
        },
        label: Text("小幫手"),
        icon: Icon(Icons.adb),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
