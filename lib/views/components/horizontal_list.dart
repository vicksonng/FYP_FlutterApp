import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/dialogflow/dialog_flow.dart';
import 'package:untitled/models/recommendations.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/views/pages/categoriesPage.dart';
import 'package:untitled/views/pages/categoryPage.dart';
import 'package:untitled/views/pages/loginPage.dart';
import 'package:untitled/views/pages/promotionPage.dart';
import 'package:untitled/views/pages/recommendationsPage.dart';
import 'package:untitled/views/pages/userPage.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height :80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:<Widget>[
          Category(
            location: 'image/new.png' ,
            caption: "精選產品",
            path: RecommendationsPage(),
          ),
          Category(
            location: 'image/sale.png' ,
            caption: '推廣優惠',
            path: PromotionPage(),
          ),
          Category(
            location: 'image/food.png' ,
            caption: '產品目錄',
            path: CategoryPage(),
          ),
          Category(
            location: 'image/member.png' ,
            caption: '會員中心',
            path: Provider.of<UserViewModel>(context, listen: true).role =="visitor" ? LoginPage() : UserPage() ,
          ),
//          Category(
//           location: 'image/recommendation.png' ,
//            caption: 'Recommendation',
//            path: CategoriesPage(),
//          ),

        ],
      ),
    );
  }
}
class Category extends StatelessWidget {
  final String location;
  final String caption;
  final dynamic path;
  Category({this.location, this.caption, this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
    child:InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => this.path));
        if(this.path == FlutterFactsChatBot()){
          print(" can check path");
        }
      },
      child: Container(
        width: 100.0,
        child:  ListTile(
          title: Image.asset(
            location,
            width:100.0,
            height: 50.0,
           ),

           subtitle: Container(
             alignment: Alignment.topCenter,
             child: Text(caption, style: new TextStyle(fontSize: 15.0),),
           ),
        ),
      ),
     ),
    );
  }
}