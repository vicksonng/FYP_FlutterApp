import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app/constant.dart';
import 'package:untitled/models/productList.dart';
import 'package:untitled/view_models/productListViewModel.dart';
import 'package:untitled/view_models/userViewModel.dart';
import 'package:untitled/views/pages/productDetailsPage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/models/product.dart';
import 'package:untitled/app/app.dart';

class ProductsListCategory extends StatelessWidget {
  final String productType;

  ProductsListCategory(this.productType);

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<ProductListViewModel>(context, listen: false).getProductsCategory(this.productType);

    // TODO: implement build
    return  GridView.builder(
                itemCount: products.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                  MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height /1.9),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductWidget(
                      product: products[index]
                  );
                }
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget({this.product});

  @override
  Widget build(BuildContext context) {
    var isSales = false;
    var userVM = Provider.of<UserViewModel>(context);

    if(product.salesBuyXGetYList.length > 0 || product.salesDiscountList.length > 0 || product.salesSpecialPriceList.length > 0){
      print("is ok");
      isSales = true;
    }

    return Container(
        height: 280,
        child: Card(
            child: Hero(
              tag: product.productName,
              child: Material(
                child: InkWell(
                  onTap: () async {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) =>
                        new ProductDetailsPage(product)
                    ));
                    var response = await userVM.addSearchHistory(product.id);
                    print(response);
                    print("added");

                  },

                  child: GridTile(
                      footer: Container(
                          padding: EdgeInsets.all(5.0),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Text(product.productName,
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "\$"+product.currentPrice.toString(),
                                style: TextStyle(
                                    color: Colors.red, fontWeight: FontWeight.w800),
                              ),

                            ],
                          )
                      ),
                      child: Stack(
                        children: <Widget>[
                          Image.network(product.picture),
                          isSales? new Container(
                              height: 80,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset("image/sales.png")
                              )
                          ): Container()
                        ],

                      )
//                    product.picture,
//                    fit: BoxFit.cover,
//                  )
                  ),
                ),
              ),

            )
        )
    );

  }
}





