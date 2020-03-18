import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view_models/cartListViewModel.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/view_models/productListViewModel.dart';


//import package here
import 'package:untitled/views/components/horizontal_list.dart';
import 'package:untitled/views/components/productsListComponent.dart';
import 'package:untitled/views/pages/categoriesPage.dart';
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


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => CartListViewModel()),
          ChangeNotifierProvider(builder: (_) => UserViewModel()),
          ChangeNotifierProvider(builder: (_) => ProductListViewModel()),
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

  Future<List<dynamic>> products;

  @override
//  initState(){
//    super.initState();
//    products = getProducts();
//  }

  Widget build(BuildContext context) {
  Widget image_carousel = new Container(
    height: 200.0,
    child: new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('image/p1.jpg'),
        AssetImage('image/p2.jpg'),
        AssetImage('image/p3.jpg'),
        AssetImage('image/p4.jpg'),
      ],
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 2000),
      dotSize: 4.0,
      indicatorBgPadding: 4.0,
    ),
  );

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('鴻福堂Online'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white,), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => new ShoppingCartPage()));
          })
        ],
      ),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: Text('NgCheukFung'),
                accountEmail: Text('16215877@life.hkbu.edu.hk'),
                currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                ),
        decoration: new BoxDecoration(
          color: Colors.green
        ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('My Account'),
                  leading: Icon(Icons.person),
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.shopping_cart),
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('My E-Coupon'),
                  leading: Icon(Icons.card_giftcard),
                )
            ),
            InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage()));
                },
                child: ListTile(
                  title: Text('Products'),
                  leading: Icon(Icons.fastfood),
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('Promotion'),
                  leading: Icon(Icons.event),
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('Recommendation'),
                  leading: Icon(Icons.favorite),
                )
            ),

            Divider(),

            InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('Setting'),
                  leading: Icon(Icons.settings),
                )
            ),
            InkWell(
                onTap: (){},
                child: ListTile(
                  title: Text('Help'),
                  leading: Icon(Icons.help),
                )
            ),

          ],
        ),
      ),
        body: new ListView(
          children: <Widget>[
            //image Carousel Begins
            image_carousel,
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
