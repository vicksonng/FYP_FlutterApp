import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view_models/promotionPageViewModel.dart';
import 'package:untitled/views/pages/promotionPage.dart';

class HomePageCarousel extends StatefulWidget{
  _HomePageCarouselState createState() => _HomePageCarouselState();
}
class _HomePageCarouselState extends State<HomePageCarousel>{

    Widget _futurePromotion(BuildContext context, AsyncSnapshot snap) {
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
            return Text("waiting");
          }
        case ConnectionState.done:
          {
            print("done");
          print(snap.data);
            if (snap.data == null) {
              return Text("No Promotion");
            } else {
              var imageList = [];
              for(int i = 0 ; i < snap.data.length ; i ++){
                imageList.add(NetworkImage(snap.data[i].promotionImgURL));
              }
              return new Container(
                height: 240.0,
                child:
                 new Swiper(
                    itemBuilder: (BuildContext context,int index){
                        return
                          new MaterialButton(
                          child:
                          Image.network(snap.data[index].promotionImgURL,fit: BoxFit.fill, ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => new PromotionPage()));
                          },
                        );
                     },

                    itemCount: snap.data.length,
                    pagination: new SwiperPagination(),
                    control: new SwiperControl(),
                   autoplay: true,
                 ),
//                new Carousel(
//                  boxFit: BoxFit.fitHeight,
//                  images: imageList,
//
////                  images: [
////                    AssetImage('image/p1.jpg'),
////                    AssetImage('image/p2.jpg'),
////                    AssetImage('image/p3.jpg'),
////                    AssetImage('image/p4.jpg'),
////                  ],
//                  autoplay: true,
//                  animationCurve: Curves.linear,
//                  autoplayDuration: Duration(seconds: 5),
//                  animationDuration: Duration(milliseconds: 2000),
//                  dotSize: 4.0,
//                  indicatorBgPadding: 4.0,
//
//                ),
              );

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
    return Container(
      child: FutureBuilder(
          builder: _futurePromotion,
          future: Provider.of<PromotionPageViewModel>(context, listen: false).getPromotion(),
      )
    );

  }



}