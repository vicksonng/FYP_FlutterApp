
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/category.dart';
import 'package:untitled/view_models/categoryViewModel.dart';
import 'package:untitled/views/components/productsListComponent.dart';
import 'package:untitled/views/pages/shoppingCartPage.dart';
import 'package:untitled/app/constant.dart';

import 'categoryProductPage.dart';

class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

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
    return category_list;
  }

  Widget _futureCategoryList(BuildContext context, AsyncSnapshot snap) {
    switch (snap.connectionState) {
      case ConnectionState.none:
        {
          print("none");
          return Text("none");
        }
      case ConnectionState.active:
        {
          print("active");
          return Text("active");
        }
      case ConnectionState.waiting:
        {
          print("waiting");
          return Text("加載中...");
        }
      case ConnectionState.done:
        {
          print("done");
          if (snap.data == null) {
            return Text("找不到任何商品");
          } else {
            return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (BuildContext context, int index){
              return CategoryWidget(snap.data[index]);
            });

          }
        }
        break;
      default:
        return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightGreen,
        title: Text('商品類型'),
        actions: <Widget>[
//          new IconButton(icon: Icon(Icons.search, color: Colors.white,),
//            onPressed: () {}),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white,),
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new ShoppingCartPage()));
                })
         ],
        ),
        body: FutureBuilder(
          future: Provider.of<CategoryViewModel>(context, listen: false).getCategory(),
          builder: _futureCategoryList
        )
    );
  }
}


//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        appBar: new AppBar(
//          elevation: 0.1,
//          backgroundColor: Colors.lightGreen,
//          title: Text('商品類型'),
//          actions: <Widget>[
//            new IconButton(icon: Icon(Icons.search, color: Colors.white,),
//                onPressed: () {}),
//            new IconButton(
//                icon: Icon(Icons.shopping_cart, color: Colors.white,),
//                onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => new ShoppingCartPage()));
//                })
//          ],
//        ),
//        body:
//        children: <Widget>[
//          Card(
//            color: Colors.lightGreen,
//            child: Container(
//              height: 200,
//              child: FittedBox(
//                child: Image.asset("image/catagory_food.jpg"),
//                fit: BoxFit.cover,
//              )
//            )
//          ),
//          Card(
//            color:Colors.green,
//          ),
//          Card(
//            color:Colors.lightGreenAccent
//
//          )
//        )
//    );
//  }
//}

class CategoryWidget extends StatelessWidget{
  final Category category;

  CategoryWidget(this.category);

  Widget build(BuildContext context){
    return Card(
      color: Colors.grey,
      child: SizedBox(
        height: 200,
        child: GridTile(
          child:  Ink(
//            decoration:
//              BoxDecoration(
//                image: DecorationImage(
//                image: ExactAssetImage(category.categoryImgPath),
//                fit: BoxFit.cover,
//              ),
//            ),
            child: InkWell(
              child: Image.network(category.categoryImgPath, fit: BoxFit.cover,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => new CategoryProductPage(this.category)));
              },
              splashColor: Colors.grey.withOpacity(0.5),
            ),
          ),
          footer:  Container(
              height: 40,
              padding: EdgeInsets.only(left: 10, top: 2, bottom: 2),
              color: Colors.lightGreen.withOpacity(0.9),
              child: Text(category.categoryName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize:25, color: Colors.white))
          ),

        ),
      ),

    );
  }
}



