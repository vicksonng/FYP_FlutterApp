import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/order.dart';

class OrderListPage extends StatelessWidget{
  final List<Order> orderList;
  OrderListPage(this.orderList);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('交易紀錄'),
        ),
        body: orderList.length > 0 ?
        ListView(
          children: <Widget>[
            ListTile(
              title: Text("以下是閣下的交易紀錄"),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: orderList.length,
                itemBuilder: (context, index){
                  return Card(
                      elevation: 5,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ExpansionTile(
                              title: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex:1,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Text("賬單編號：", style: TextStyle(fontSize: 12),),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(orderList[index].id.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                          )
                                        ],
                                      )
                                  ),
                                  Expanded(
                                      flex:1,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Text("總金額 \$ ", style: TextStyle(fontSize: 12) ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(orderList[index].total.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                                          )
                                        ],
                                      )
                                  ),
                                  Expanded(
                                      flex:2,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Text("日期： ", style: TextStyle(fontSize: 12)),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(orderList[index].date.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                                          )
                                        ],
                                      )
                                  ),

                                ],
                              ),
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("賬單詳情如下："),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("商品名稱")
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text("數量")
                                        )

                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text("金額")
                                        )

                                    ),

                                  ],

//
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),

                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: orderList[index].itemList.length,
                                itemBuilder: (context, i) {
                                  return
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child:Text(orderList[index].itemList[i].productName)
                                              )
                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(orderList[index].itemList[i].qty.toString())
                                              )

                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text("\$ "+orderList[index].itemList[i].subTotal.toString())
                                              )


                                          ),
                                        ],
                                      )
                                      )
                                    );
                                },

                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                  child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Spacer(flex:1),
                                          Spacer(flex:1),
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text("\$ "+ orderList[index].total.toString())
                                              )

                                          ),
                                        ],
                                      )
                                  )
                              )
                            ],
                          )
                      )
                  );
                }
            )
//            Card(
//
//              elevation: 10,
//              child: Padding(
//                padding: EdgeInsets.all(10),
//                child:
//
//              )
//            )
         ]
      ): Center(
        child: Text("閣下沒有任何交易紀錄"),
      ),
    );

  }
}



