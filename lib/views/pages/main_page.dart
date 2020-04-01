//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:untitled/view_models/main_page_view_model.dart';
//import 'package:untitled/view_models/productListViewModel.dart';
//import 'package:carousel_pro/carousel_pro.dart';
//import 'package:untitled/views/pages/shoppingCartPage.dart';
//
//import 'categoriesPage.dart';
//
//class MainPage extends StatefulWidget{
//  final MainPageViewModel viewModel;
//
//  MainPage({Key key , @required this.viewModel}) : super(key: key);
//
//
//  @override
//  _MainPageState createState() => _MainPageState();
//
//}
//
//class _MainPageState extends State<MainPage>{
//  void initState() {
//    super.initState();
//    // you can uncomment this to get all batman movies when the page is loaded
//    Provider.of<ProductListViewModel>(context, listen: false).fetchProducts();
//  }
//
//
//  Widget build(BuildContext context) {
//    Widget image_carousel = new Container(
//      height: 200.0,
//      child: new Carousel(
//        boxFit: BoxFit.cover,
//        images: [
//          AssetImage('image/p1.jpg'),
//          AssetImage('image/p2.jpeg'),
//          AssetImage('image/p3.jpg'),
//          AssetImage('image/p4.jpg'),
//        ],
//        autoplay: true,
//        animationCurve: Curves.fastOutSlowIn,
//        animationDuration: Duration(milliseconds: 1000),
//        dotSize: 4.0,
//        indicatorBgPadding: 4.0,
//      ),
//    );
//
//    return Scaffold(
//      appBar: new AppBar(
//        backgroundColor: Colors.lightGreen,
//        title: Text('鴻福堂Online'),
//        actions: <Widget>[
//          new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
//          new IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white,), onPressed: (){
//            Navigator.push(context, MaterialPageRoute(builder: (context) => new ShoppingCartPage()));
//          })
//        ],
//      ),
//
//      drawer: new Drawer(
//        child: new ListView(
//          children: <Widget>[
//            new UserAccountsDrawerHeader(
//              accountName: Text('NgCheukFung'),
//              accountEmail: Text('16215877@life.hkbu.edu.hk'),
//              currentAccountPicture: GestureDetector(
//                child: new CircleAvatar(
//                  backgroundColor: Colors.grey,
//                  child: Icon(Icons.person, color: Colors.white),
//                ),
//              ),
//              decoration: new BoxDecoration(
//                  color: Colors.green
//              ),
//            ),
//            InkWell(
//                onTap: (){},
//                child: ListTile(
//                  title: Text('Home Page'),
//                  leading: Icon(Icons.home),
//                )
//            ),
//            InkWell(
//                onTap: (){},
//                child: ListTile(
//                  title: Text('My Account'),
//                  leading: Icon(Icons.person),
//                )
//            ),
//            InkWell(
//                onTap: (){},
//                child: ListTile(
//                  title: Text('My Orders'),
//                  leading: Icon(Icons.shopping_cart),
//                )
//            ),
//            InkWell(
//                onTap: (){},
//                child: ListTile(
//                  title: Text('My E-Coupon'),
//                  leading: Icon(Icons.card_giftcard),
//                )
//            ),
//            InkWell(
//                onTap: (){
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()));
//                },
//                child: ListTile(
//                  title: Text('Products'),
//                  leading: Icon(Icons.fastfood),
//                )
//            ),
//            InkWell(
//                onTap: (){},
//                child: ListTile(
//                  title: Text('Promotion'),
//                  leading: Icon(Icons.event),
//                )
//            ),
//            InkWell(
//                onTap: (){},
//                child: ListTile(
//                  title: Text('Recommendation'),
//                  leading: Icon(Icons.favorite),
//                )
//            ),
//
//            Divider(),
//
//            InkWell(
//                onTap: (){},
//                child: ListTile(
//                  title: Text('Setting'),
//                  leading: Icon(Icons.settings),
//                )
//            ),
//            InkWell(
//                onTap: (){},
//                child: ListTile(
//                  title: Text('Help'),
//                  leading: Icon(Icons.help),
//                )
//            ),
//
//          ],
//        ),
//      ),
//      body: new ListView(
//        children: <Widget>[
//          //image Carousel Begins
//          image_carousel,
//          //padding
//          new Padding(padding: const EdgeInsets.all(8),
//            child: new Text('Categories'),),
//          //Categories List
//          HorizontalList(),
//          new Padding(padding: const EdgeInsets.all(15),
//            child: new Text('Recent products'),
//          ),
//
//          Container(
//            height: 320.0,
//            child: Products('ALL'),
//          )
//        ],
//      ),
//    );
//  }
//
//
//}