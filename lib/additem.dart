import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


Widget sel3a(BuildContext context,var document,int index, var email) {
  ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
  return document != null ?  Dismissible(
    onDismissed: (value){
      Firestore.instance.collection(document['Type']).document(document.documentID).delete();
      Firestore.instance.collection(email).document(document.documentID).delete();
    },
    direction: DismissDirection.startToEnd,
    background: Container(
      alignment: Alignment.centerLeft,
      color: Colors.green[400],
      child: Padding(
        padding:  EdgeInsets.only(left: ScreenUtil().setWidth(40)),
        child: Icon(Icons.check,color: Colors.white,size: ScreenUtil().setSp(100),),
      ),
    ),
    key: UniqueKey(),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: StreamBuilder(
        stream: Firestore.instance.collection(email).document(document.documentID).snapshots(),
        builder: (context,snap){
          if(snap.data != null){
            return  Container(
              margin: EdgeInsets.symmetric(vertical: 3,horizontal: 12),
              height: ScreenUtil().setHeight(460),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors:index==0?[
                        Colors.grey.shade200,
                        Colors.grey.shade200,
                      ] :[
                        // Colors.greenAccent.withOpacity(0.8),
                        //Colors.green.withOpacity(0.8),
                        Colors.grey.shade200,
                        Colors.grey.shade200,
                      ]
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2.0,
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2.0
                    )
                  ]
              ),
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: PageView(
                      pageSnapping: true,
                      allowImplicitScrolling: false,
                      scrollDirection: Axis.horizontal,
                      controller: PageController(
                        initialPage: 0,
                        keepPage: true,
                        viewportFraction: 1,
                      ),
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                  padding: EdgeInsets.only(top:10,bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text("                            PROUDUCT    "
                                          "              ",style: TextStyle( fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.w600),),
                                      Switch(
                                        onChanged: (value){
                                          print("");
                                        },
                                        value: snap.data['isReserved']==null?false:snap.data['isReserved'],

                                      ),

                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: <Widget>[
                                        vendeur_text_pageview(
                                            context, document['Title'], "Title"),
                                        vendeur_text_pageview(
                                            context, document["Type"], "Type"),
                                        vendeur_text_pageview(
                                            context, document['Description'], "Description"),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Icon(Icons.arrow_forward_ios,size: 50,color: Colors.white70,))
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Center(
                                child:  Container(
                                    padding: EdgeInsets.only(top:10,bottom: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Text("                            PROUDUCT    "
                                            "              ",style: TextStyle( fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.w600),),
                                        Switch(
                                          onChanged: (value){
                                            print("");
                                          },
                                          value: snap.data['isReserved']==null?false:snap.data['isReserved'],

                                        ),
                                      ],
                                    ))
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: <Widget>[
                                        vendeur_text_pageview(
                                            context, document['Weight'], "Weight"),
                                        vendeur_text_pageview(
                                            context, document['Quantity'], "Quantity"),

                                      ],
                                    ),
                                  ),
                                  Expanded(child: Icon(Icons.arrow_forward_ios,size: 50,color: Colors.white70,))

                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                  padding: EdgeInsets.only(top:10,bottom: 2),
                                  child: Text("Collector",style: TextStyle( fontSize: ScreenUtil().setSp(34),fontWeight: FontWeight.w600),)),
                            ),
                            (snap.data['isReserved']==null?false:snap.data['isReserved'])? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  vendeur_text_pageview(
                                      context, snap.data['vend'], "Name"),
                                  vendeur_text_pageview(
                                      context, document['vendnum'], "Number")


                                ],
                              ),
                            ):Center(child:Text(
                              "\n\n\ndidn't reserved",
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),
                            )),
                          ],
                        ),

                      ],
                    ),
                  )
                ],
              ),
            );
          };
          return Container();
        },
      ),
    ),
  ):Center(child: Container(child: Text("il y'a pas pour le moment"),),);
}


Widget vendeur_text_pageview(
    BuildContext context, String subtitle, String title) {
  ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
  return Container(
    height: ScreenUtil().setHeight(110),
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Text(
              "$title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(32)),
            )),
        Expanded(
            child: Text(
              "$subtitle",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: ScreenUtil().setSp(32)),
            )),
      ],
    ),
  );
}
