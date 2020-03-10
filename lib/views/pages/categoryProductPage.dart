import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/category.dart';
import 'package:untitled/views/components/productsListComponent.dart';
import 'package:untitled/views/pages/shoppingCartPage.dart';

class CategoryProductPage extends StatefulWidget{
  Category category;
  CategoryProductPage(this.category);


  _CategoryProductPageState createState() => new _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightGreen,
        title: Text('商品種類'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color: Colors.white,),
              onPressed: () {}),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => new ShoppingCartPage()));
              })
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Container(
              height: 300,
//        child: FittedBox(
//          fit: BoxFit.cover,
              child: GridTile(
                child: FittedBox(
                  child: Image.asset(widget.category.categoryImgPath),
                  fit: BoxFit.cover,
                ),
                footer: Container(
                      padding: EdgeInsets.only(left: 10, top: 2, bottom: 2),
                      color: Colors.lightGreen.withOpacity(0.9),
                      child: Text(widget.category.categoryName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white))
                  

                )
//          )
              )
          ),
          Container (
            child:  Text("商品列表"),
            padding: EdgeInsets.all(8),

          ),


          Container(
            child: new ProductsListComponent(widget.category.productType),
            height: 400,

          )




        ],
      )


    );

  }
}