import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/views/components/recommendationsHorizontal.dart';
import 'package:untitled/models/recommendations.dart';

class RecommendationsPage extends StatefulWidget{
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage>{

  @override
  Widget build(BuildContext context) {
    List<Recommendations> recommendations = [
      new Recommendations("專屬推介", Constant.recommendationsUbcfUrl + Provider.of<UserViewModel>(context).userID.toString()),
      new Recommendations("最暢銷商品", Constant.recommendationsTopSalesUrl),
      new Recommendations("最受注目商品", Constant.recommendationsTopViewUrl)
    ];
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('精選推介'),
        actions: <Widget>[
                new IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
            ],
        ),
      body: ListView.builder(
          itemCount: recommendations.length,
          itemBuilder: (BuildContext context, int index){
              return RecommendationsHorizontalComponent(recommendations[index]);

          }
      ),
    );
  }
}