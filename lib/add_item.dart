import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'additem.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';



class jibley_home extends StatefulWidget {
  var email;
    jibley_home(this.email);
  @override
  _jibley_homeState createState() => _jibley_homeState(email);
}

class _jibley_homeState extends State<jibley_home> {
  var email;
  _jibley_homeState(this.email);
  TextStyle oswold = GoogleFonts.oswald();
  List nom = ["ahmed", "hohamed nabil", "mouslim messaoudi","nabil aguida"];
  TextEditingController jibleycode = TextEditingController();
  String healper = "" ;

  Color hintcolor = Colors.grey[500] ;
  final _formKey = GlobalKey<FormState>();
  Location location = new Location();
  Geoflutterfire geo = Geoflutterfire();
  Firestore firestore = Firestore.instance;
  String title, type, description, number,weight,dropdownValue = 'Choose item type';
  var sp = <String>['Choose item type','Paper','Organic','Plastic','Metal','Wood','Clothes','Glass','Electronics','Other'];
  var point;
  Map<String,String> item;
  bool loading = false;
  List items = [''];
  List docs = [''];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            _showAlertDialog();
          },
          child: Icon(Icons.add,size: 25,),
          backgroundColor: Color(0xff00b76c),
        ),
        backgroundColor: Colors.grey[200],
//        appBar: AppBar(
//          actions: <Widget>[
//            IconButton(
//                icon: Icon(Icons.add),
//                onPressed: ()=>showDialog(
//                    context: context,builder: (BuildContext context){
//                  return AlertDialog(
//                    content: TextField(
//                      style: TextStyle(fontSize: ScreenUtil().setSp(40)),
//                      decoration : InputDecoration(
//                          hintText: "code de vendeur",
//                          hintStyle: TextStyle(
//                              color: hintcolor
//                          )
//                      ),
//                      controller: jibleycode,
//                      onChanged: (valeu){
//                        setState(() {
//                          hintcolor = Colors.grey[500];
//                        });
//                      },
//
//                    ),
//                    actions: <Widget>[
//                      FlatButton(
//                        onPressed:()async{
//                          if(jibleycode.text.length > 3){
//                            await Firestore.instance.collection("code").add({
//                              "code" : jibleycode.text.toString().trim()
//                            });Navigator.pop(context);jibleycode.clear();
//                          }else{
//                            jibleycode.clear();
//                            setState(() {
//                              hintcolor =Colors.red ;
//                            });
//                          }
//
//
//                        }, child: Text("Enregistrer",
//                        style: TextStyle(
//                            fontSize: ScreenUtil().setSp(32),
//
//                            color: Colors.green[400]
//                        )
//                        ,
//                      ),
//                      )
//                    ],
//                  );
//                }
//                )
//            )
//          ],
//          title: Text(
//            "JIBLEY",
//
//            style: TextStyle(fontSize: ScreenUtil().setSp(40)),
//          ),
//          centerTitle: true,
//          backgroundColor: Color(0xff00b76c),
//        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 12,),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(child: Icon(Icons.arrow_back,size: 32,)),
                  Expanded(child: Text("Home",
                      style: GoogleFonts.montserrat(fontSize: 28,fontWeight: FontWeight.w400,color: Colors.black87,)
                  ),
                  flex: 4,),
                  Expanded(child: Container(
                    margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade200,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey, spreadRadius: 3, blurRadius: 55)
                          ]),
                      height:50,
                      width:50,
                      child: Icon(Icons.location_on,size: 32,))),

                ],
              ),
            ),
            SizedBox(height: 12,),

            Container(
              height: 240,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/vend.png"),fit: BoxFit.fill)
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection(email).snapshots(),
              builder: (context,snapshoot){
                print(email);
                List l = snapshoot.data.documents.map((document)=>sel3a(context,document,0,email)).toList();
                if (snapshoot.hasData == null || l.length == 1)return Center(child:Column(
                  children: <Widget>[
                    SizedBox(height: 35,),
                    Icon(Icons.info,size: 35,color: Colors.grey,),
                    Text("\nNo Item Add",
                    style: TextStyle(fontSize: 25,color: Colors.grey,),
                    ),
                  ],
                ) );
                switch(snapshoot.connectionState){
                  case ConnectionState.waiting :return Center(child: CircularProgressIndicator());
                  default :    return Container(
                    height: (makelist(snapshoot, 0).length-1)*250.0,
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => makelist(snapshoot, index).elementAt(index),
                      itemCount: makelist(snapshoot, 0).length,

                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  void _showAlertDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return AlertDialog(
                  title: Text("Add new item details"),
                  content: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Title',
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[400],
                              ),
                            ),
                            validator: (val) => (val.isEmpty) ? 'Enter a valid title': null,
                            onChanged: (val){
                              setState(() => title = val);
                            },
                          ),
                          DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              items: sp.map<DropdownMenuItem<String>>((String value){
                                return DropdownMenuItem<String>(value: value,child: Text(value),);
                              }).toList(),
                              onChanged: (String newValue){
                                setState((){
                                  dropdownValue = newValue;
                                  print(dropdownValue);
                                });
                              }
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Quantity',
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[400],
                              ),
                            ),
                            validator: (val) => (val.isEmpty)? 'Enter a valid quantity': null,
                            onChanged: (val){
                              setState(() => number = val);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Weight in kg',
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[400],
                              ),
                            ),
                            onChanged: (val){
                              setState(() => weight = val);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Add descrition',
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[400],
                              ),
                            ),
                            onChanged: (val){
                              setState(() => description = val);
                            },
                          ),
                        SizedBox(height: 60,),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("images/dh7ka-8.png",),)
                          ),
                        )
                        ],)),
                  actions: <Widget>[
                    FlatButton(
                      //add item to pecific collection 'paper,..'
                      //add item id and type to user document item <DocumentId,CollectionName>
                        child: Text('Confirm'),
                        onPressed: () async {
                          try{
                            if (_formKey.currentState.validate()) {
                              _addLocation();
                              print(point);
                              var doc = await  _addNewItem();
                            //  await _updateUserItems(doc);
                              //_showSuccessMessage();
                              Navigator.of(context).pop();

                            }
                          }catch(e){
                            print(e);
                            //_showErrorMessage(e.message);
                          }
                        }
                    ),
                    FlatButton(
                      child: Text('Decline'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );}
          );
        }
    );
  }

  Future<DocumentReference> _addNewItem() async {
    var docu = await firestore.collection(email).document(email).get();
    print(point.data);
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    final doc =  await firestore.collection(dropdownValue).add({
      'Title': title,
      'email':firebaseUser.email,
      'Type': dropdownValue,
      'Description': description,
      'Quantity': number,
      'Location': point.data,
      'Weight': weight,
      'Owner': 'OlRE1Ss0b120Mowy476M',
      'isReserved': false,
      "Name":docu['Name'],
      "Number":docu['Number']
    });
    final doc2 =  await firestore.collection(firebaseUser.email).document(doc.documentID).setData({
      'Title': title,
      'email':firebaseUser.email,
      'Type': dropdownValue,
      'Description': description,
      'Quantity': number,
      'Location': point.data,
      'Weight': weight,
      'Owner': 'OlRE1Ss0b120Mowy476M',
      'isReserved': false,
      "Name":docu['Name'],
      "Number":docu['Number']
    });
    print('done');
    return doc;
  }

  Future _updateUserItems(DocumentReference doc) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    item = ({'Type': dropdownValue,'Id':doc.documentID});
    firestore.collection('users').document(firebaseUser.uid).updateData({
      "Items" : FieldValue.arrayUnion([item]),
    });


    //_updateItemList();
  }
  List<Widget> makelist(AsyncSnapshot snapshot,int index) {

    return snapshot.data.documents.map<Widget>((document) {
      if(document.documentID.toString() != email){
        return  sel3a(context, document, index, email);
      }
      else {return Container() ;}
    }).toList();
  }


  ///---------

  void _addLocation() async{
    var pos = await location.getLocation();
    GeoFirePoint _point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    print(_point.data);
    setState((){
      point = _point;
    });
  }

  @override
  void initState() {
    //_updateItemList();
    print('here');
    super.initState();
  }
}







