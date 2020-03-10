

import 'package:flutter/material.dart';
import 'package:untitled/models/category.dart';
import 'package:untitled/views/components/productsListComponent.dart';
import 'package:untitled/views/pages/shoppingCartPage.dart';

import 'categoryProductPage.dart';

class CategoriesPage extends StatelessWidget{
  final List<Category> categoryList = [
    new Category("保鮮瓶裝飲品", "image/category_LSLD.jpg", "LSLD"),
    new Category("中式湯品", "image/category_CS.jpg", "CS"),
    new Category("甘露系列", "image/category_ND.jpg", "ND"),
    new Category("鮮製飲品", "image/category_FDP.jpg", "FDP"),
    new Category("自家系列", "image/category_HS.jpg", "HS"),
    new Category("自家甜品", "image/category_HD.jpg", "HD"),
    new Category("自家喜慶及節慶系列", "image/category_HJFS.jpg", "HJFS"),
    new Category("龜苓膏及草本膏品", "image/category_THJ.jpg", "THJ")
    ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightGreen,
        title: Text('商品類型'),
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
      body: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int index){
          return CategoryWidget(categoryList[index]);
        }

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
      )
    );
  }
}

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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage(category.categoryImgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: InkWell(
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


//    );


//    return Card(
//        color: Colors.lightGreen,
//
//      child: Material(
//        child: InkWell(
//              splashColor: Colors.grey,
//              onTap: (){},
//
//              child: Container(
//                  height: 200,
//                  child: FittedBox(
//                    child: Image(
//                        image: AssetImage(category.categoryImgPath)
//                    ),
//                    fit: BoxFit.cover,
//                  )
//              )
//          )
//        )
//
//    );

//    return InkWell(
//      splashColor: Colors.grey,
//      onTap: (){},
//      child: Card(
//          color: Colors.lightGreen,
//          child: Container(
//              height: 200,
//              child: FittedBox(
//                child: Image(
//                    image: AssetImage(category.categoryImgPath)
//                ),
//                fit: BoxFit.cover,
//              )
//          )
//      )
//
//    );
  }
}



