import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:untitled/models/category.dart';
import 'package:untitled/views/pages/categoryPage.dart';

class CategoryMessage extends StatelessWidget{
//  String text;
  List<Category> categories;
  Function(String) callback;

  CategoryMessage(this.categories, this.callback);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(5),
      child:
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
              title: Text("請問你想要什麼類型的商品呢？")
          ),
          Container(
            height: 300,
            width : 300,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new CategoryWidget(this.categories[index], this.callback);
              },
              itemCount: this.categories.length,
              viewportFraction: 0.8,
              scale: 0.9,
            )

          )

        ],

      )
    );
  }


}

class CategoryWidget extends StatelessWidget{
  final Category category;
  Function(String) callback;
  CategoryWidget(this.category, this.callback);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Container(
        child: Card(
            child: GridTile(
                child: Container(
                    height: 100,
                    child: InkResponse(
                      child: Image.network(category.categoryImgPath, fit: BoxFit.cover),
                      onTap: (){
                        var query = category.categoryName;
                        callback(category.categoryName);

                      },
                    )
                ),
                footer: Container(
                  height: 30,
                  color: Colors.lightGreen,
                  child: Center(
                    child: Text(category.categoryName, style: TextStyle(color: Colors.white, fontSize: 20),),
                  )
                )
            )
        ),
        height :150,
      );
    }
}


