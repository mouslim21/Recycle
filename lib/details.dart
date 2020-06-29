
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slimy_card/slimy_card.dart';



class HomePage extends StatefulWidget {
  var doc;
  var colname;
  HomePage(this.doc,this.colname,this.vendname);
  String vendname;
  @override
  _HomePageState createState() => _HomePageState(doc,colname,vendname);
}

class _HomePageState extends State<HomePage> {
  var colname;
  var doc;
  String vendname;
  _HomePageState(this.doc,this.colname,this.vendname);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("images/bg.png")
          )
        ),
        child: StreamBuilder(
          // This streamBuilder reads the real-time status of SlimyCard.
          initialData: false,
          stream: slimyCard.stream, //Stream of SlimyCard
          builder: ((BuildContext context, AsyncSnapshot snapshot) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[

                Row(
                  children: <Widget>[

                    Padding(
                     padding: EdgeInsets.only(
                       top: 32,
                           left:10,
                      // right: MediaQuery.of(context).size.width/1.2,
                     ),
                      child: GestureDetector(
                        onTap: ()=>Navigator.of(context).pop(),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, spreadRadius: 3, blurRadius: 55)
                              ]),
                          height:50,
                          width:50,
                          child:Icon(Icons.arrow_back,size: 30,color: Colors.black87,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 32,
                        // top: MediaQuery.of(context).size.height/22, right: MediaQuery.of(context).size.width/15,
                        left: MediaQuery.of(context).size.width/1.5,
                      ),
                      child: GestureDetector(
                        onTap: ()=>Navigator.of(context).popUntil((route) => route.isFirst),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, spreadRadius: 3, blurRadius: 55)
                              ]),
                          height:50,
                          width:50,
                          child:Icon(Icons.home,size: 30,color: Colors.black87,),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 58),

                // SlimyCard is being called here.
                SlimyCard(
                 topCardHeight: 280,
                  bottomCardHeight: 100,
                  // In topCardWidget below, imagePath changes according to the
                  // status of the SlimyCard(snapshot.data).
                  topCardWidget: topCardWidget(doc),
                  bottomCardWidget: bottomCardWidget(doc,colname,vendname),
                  color: Color(0xff00b76c),
                ),
//              Expanded(
//
//                child: GestureDetector(
//
//                  child: Container(
//                    margin: EdgeInsets.only(right: 30,left: 30,top: 30),
//                    padding: EdgeInsets.only(left: 25,right: 75,top:10,bottom:10),
//                    decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                          colors:[Color(0xff00b76c),Color(0xff4A9475),]),
//                      borderRadius: BorderRadius.circular(12),
//
//                    ),
//                    child:Center(
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Expanded(child: Container(),flex: 4,),
//                          Expanded(
//                            flex:25,
//                            child: Text(" Ajouter",style: TextStyle(
//                                color: Colors.white,
//                                fontSize: 30,
//                                fontWeight: FontWeight.w500
//                            ),),
//                          ),
//                          // SizedBox(width:ScreenUtil().setWidth(120)),
//                          Expanded(child: Icon(Icons.shopping_cart,color: Colors.white,size: 25,))
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              )

              ],
            );
          }),
        ),
      ),
    );
  }

  // This widget will be passed as Top Card's Widget.
  Widget topCardWidget(var imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

//        Text(
//          'Details',
//          style: TextStyle(color: Colors.white, fontSize: 20),
//        ),
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage("images/rec.png")),
//            boxShadow: [
//              BoxShadow(
////                color: Colors.black.withOpacity(0.1),
//                blurRadius: 20,
//                spreadRadius: 1,
//              ),
//            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
         doc.data['Name'],
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          doc.data['Number'],
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        SizedBox(height: 15),
        Text(
          'Weight: '+doc.data['Weight']+', Quantity:  '+doc.data['Quantity']+',\nDescription: '+doc.data['Description'],textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 15,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 25),
        Text(
          'reserve now!!',textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 17,
              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget(var doc,var colname,String vendname) {
    bool isSwitched = false;
    return StreamBuilder(
      stream: Firestore.instance.collection(colname).document(doc.documentID).snapshots(),
      builder: (context,snap){
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snap.data['isReserved']?
              Text("this item alerady taking ",style: GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w200,color: Colors.white,)):
              Text("clique here to take it ",style: GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w200,color: Colors.white,),),
          Switch(
            value: snap.data['isReserved'],
            onChanged: (value)async {
              if (!snap.data['isReserved']) {
                Firestore.instance.collection(colname)
                    .document(doc.documentID)
                    .updateData({
                  "isReserved": true
                });

                  var a = await Firestore.instance.collection(vendname)
                      .document(vendname)
                      .get();
                  await Firestore.instance.collection(snap.data['email']).document(
                      doc.documentID).updateData({
                    "vend": a['Name'],
                    "vendnum": a['Number']
                  });
//                Firestore.instance.collection(snap.data['email'])
//                    .document(doc.documentID)
//                    .updateData({
//                  "vend": a['Name'],
//                  "vendnum": a['Number']
//                });
                Firestore.instance.collection(snap.data['email'])
                    .document(doc.documentID)
                    .updateData({
                  "isReserved": true
                });

//                  Firestore.instance.collection(snap.data['email']).document(
//                      doc.documentID).updateData({
//                    "vend": a['Name'],
//                    "vendnum": a['Number']
//                  });
                  print(snap.data['isReserved']);

              };
            }),

            ],
          ),
        );
      },
    );
  }
}