//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:geoflutterfire/geoflutterfire.dart';
//import 'package:location/location.dart';
//
//import 'map.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Home(),
//    );
//  }
//}
//
//class Home extends StatefulWidget {
//  @override
//  _HomeState createState() => _HomeState();
//}
//
//class _HomeState extends State<Home> {
//
//  final _formKey = GlobalKey<FormState>();
//  Location location = new Location();
//  Geoflutterfire geo = Geoflutterfire();
//  Firestore firestore = Firestore.instance;
//  String title, type, description, number,weight,dropdownValue = 'Choose item type';
//  var sp = <String>['Choose item type','Paper','Organic','Plastic','Metal','Wood','Clothes','Glass','Electronics','Other'];
//  var point;
//  Map<String,String> item;
//  bool loading = false;
//  List items = [''];
//  List docs = [''];
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      child: Scaffold(
//          appBar: AppBar(
//            title: Text('Home'),
//            actions: <Widget>[
//              FlatButton(
//                  child: Text('Go to map'),
//                  onPressed: (){
//                    Navigator.push(context, MaterialPageRoute(builder: (context){
//                      return Container();
//                    },));
//                  }
//              ),
//            ],
//          ),
//          body: Center(
//            child: Column(
//              children: <Widget>[
//                SizedBox(
//                  child: RaisedButton(
//                      child: Row(
//                        children: <Widget>[
//                          Icon(Icons.add),
//                          Text('add new item'),
//                        ],
//                      ),
//                      onPressed: (){
//                        _addEntry();
//                      }
//                  ),
//                ),
//
//                //fetch all items here
//                items != null ? !loading ? ListView.builder(
//                    shrinkWrap: true,
//                    itemCount: items.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      return Card(
//                        margin: EdgeInsets.only(left:50, right:50, bottom: 5),
//                        child:Row(
//                          children: <Widget>[
//                            Wrap(
//                              children: <Widget>[
//                                IconButton(onPressed: (){
//                                  print(docs);
//                                  _showDeleteMessage(docs[index].documentID, items[index]['Type']);
//                                }, icon: Icon(Icons.delete)),
//                                //checkbox
//                              ],
//                            ),
//                            Column(
//                                children:[
//                                  Row(
//                                    children: <Widget>[
//                                      Text('Title : '),
//                                      Text(items[index]['Title'])
//                                    ],
//                                  ),
//                                  Row(
//                                    children: <Widget>[
//                                      Text('Type  :  '),
//                                      Text(items[index]['Type'])
//                                    ],
//                                  ),
//                                  Row(
//                                    children: <Widget>[
//                                      Text('Quantity : '),
//                                      Text(items[index]['Quantity'])
//                                    ],
//                                  ),
//                                  Row(
//                                    children: <Widget>[
//                                      Text('Weight : '),
//                                      Text(items[index]['Weight'])
//                                    ],
//                                  ),
//                                  Row(
//                                    children: <Widget>[
//                                      Text('Description : '),
//                                      Text(items[index]['Description'])
//                                    ],
//                                  ),])
//                          ],
//                        ),
//                      );
//                    }
//                ): CircularProgressIndicator():Text("You have no items for recycle"),
//                //RaisedButton(onPressed: (){_updateItemList();})
//              ],
//            ),
//          )
//      ),
//    );
//  }
//
//  void _showDeleteMessage(String id,collection){
//    showDialog(
//        context: context,
//        builder: (BuildContext context){
//          return StatefulBuilder(
//              builder: (BuildContext context, StateSetter setState){
//                return AlertDialog(
//                  title: Text("Delete Item"),
//                  content: Text('Are you sure you want to delete this item ?'),
//                  actions: <Widget>[
//                    FlatButton(
//                      child: Text('Ok'),
//                      onPressed: (){
//                        _deleteEntry(id, collection);
//                        _updateItemList();
//                        Navigator.of(context).pop();
//                      },
//                    ),
//                    FlatButton(
//                      child: Text('Dismiss'),
//                      onPressed: (){
//                        Navigator.of(context).pop();
//                      },
//                    ),
//                  ],
//                );
//              }
//          );}
//    );
//  }
//
//  void _deleteEntry(String id, collection){
//    _removeFromCollection(id, collection);
//    _removeFromUser(id, collection);
//  }
//
//  void _removeFromCollection(String id, String collection) async {
//    await firestore.collection(collection).document(id).delete().then((_){
//      print('success !');
//    });
//  }
//
//  void _removeFromUser(String id, String collection) async {
//    var firebaseUser = await FirebaseAuth.instance.currentUser();
//    var item = ({'Type': collection,'Id':id});
//    firestore.collection('users').document(firebaseUser.uid).updateData({
//      "Items" : FieldValue.arrayRemove([item]),
//    });
//  }
//
//
//
//  void _ReserveItem(String id, String collection) async{
//    await firestore.collection(collection).document(id).setData({
//      'isReserved': true
//    });
//  }
//
//  void _updateItemList(){
//    setState(() {
//      loading = true;
//      items.clear();
//      _getItems();
//    });
//  }
//
//
//  void _getItems() async{
//    //array of <CollectionName,DocumentId>
//    List array;
//    var firebaseUser = await FirebaseAuth.instance.currentUser();
//    firestore.collection('users').document(firebaseUser.uid).get().then((value){
//      array = value.data['Items'];
//      print(value.data);
//      items = [array[0]];
//      items.clear();
//      docs.clear();
//      for (int i =0; i<array.length; i++){
//        print(array[i]['Type']); print(array[i]['Id']);
//        _getItemDetails(array[i]['Type'],array[i]['Id'] );
//      }
//      loading = false;
//    });
//  }
//
//  void _getItemDetails(String collection,id) async {
//    firestore.collection(collection).document(id).snapshots().listen((result){
//      print(result.data);
//      items.add(result.data);
//      docs.add(result);
//
//      loading = false;
//    });
//  }
//
//
//  void _addEntry(){
//    _addLocation();
//    _showAlertDialog();
//  }
//
//  void _showErrorMessage(String error){
//    showDialog(
//        context: context,
//        builder: (BuildContext context){
//          return AlertDialog(
//            title: Text("Error"),
//            content: Text(error),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Go back'),
//                onPressed: (){
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          );
//        }
//    );
//  }
//
//  void _showSuccessMessage(){
//    showDialog(
//        context: context,
//        builder: (BuildContext context){
//          return AlertDialog(
//            title: Text("Success !"),
//            content: Text('Your Item has been added successfully.'),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Ok'),
//                onPressed: (){
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          );
//        }
//    );
//  }
//
//  void _showAlertDialog(){
//    showDialog(
//        context: context,
//        builder: (BuildContext context){
//          return StatefulBuilder(
//              builder: (BuildContext context, StateSetter setState){
//                return AlertDialog(
//                  title: Text("Add new item details"),
//                  content: Form(
//                      key: _formKey,
//                      child: Column(
//                        children: <Widget>[
//                          TextFormField(
//                            decoration: InputDecoration(
//                              hintText: 'Title',
//                              hintStyle: TextStyle(
//                                fontSize: 17,
//                                color: Colors.grey[400],
//                              ),
//                            ),
//                            validator: (val) => (val.isEmpty) ? 'Enter a valid title': null,
//                            onChanged: (val){
//                              setState(() => title = val);
//                            },
//                          ),
//                          DropdownButton<String>(
//                              value: dropdownValue,
//                              icon: Icon(Icons.arrow_drop_down),
//                              items: sp.map<DropdownMenuItem<String>>((String value){
//                                return DropdownMenuItem<String>(value: value,child: Text(value),);
//                              }).toList(),
//                              onChanged: (String newValue){
//                                setState((){
//                                  dropdownValue = newValue;
//                                  print(dropdownValue);
//                                });
//                              }
//                          ),
//                          TextFormField(
//                            decoration: InputDecoration(
//                              hintText: 'Quantity',
//                              hintStyle: TextStyle(
//                                fontSize: 17,
//                                color: Colors.grey[400],
//                              ),
//                            ),
//                            validator: (val) => (val.isEmpty)? 'Enter a valid quantity': null,
//                            onChanged: (val){
//                              setState(() => number = val);
//                            },
//                          ),
//                          TextFormField(
//                            decoration: InputDecoration(
//                              hintText: 'Weight in kg',
//                              hintStyle: TextStyle(
//                                fontSize: 17,
//                                color: Colors.grey[400],
//                              ),
//                            ),
//                            onChanged: (val){
//                              setState(() => weight = val);
//                            },
//                          ),
//                          TextFormField(
//                            decoration: InputDecoration(
//                              hintText: 'Add descrition',
//                              hintStyle: TextStyle(
//                                fontSize: 17,
//                                color: Colors.grey[400],
//                              ),
//                            ),
//                            onChanged: (val){
//                              setState(() => description = val);
//                            },
//                          ),
//
//                        ],)),
//                  actions: <Widget>[
//                    FlatButton(
//                      //add item to pecific collection 'paper,..'
//                      //add item id and type to user document item <DocumentId,CollectionName>
//                        child: Text('Confirm'),
//                        onPressed: () async {
//                          try{
//                            if (_formKey.currentState.validate()) {
//                              var doc = await  _addNewItem();
//                              await _updateUserItems(doc);
//                              _showSuccessMessage();
//                              Navigator.of(context).pop();
//
//                            }
//                          }catch(e){
//                            print(e);
//                            _showErrorMessage(e.message);
//                          }
//                        }
//                    ),
//                    FlatButton(
//                      child: Text('Decline'),
//                      onPressed: () {
//                        Navigator.of(context).pop();
//                      },
//                    ),
//                  ],
//                );}
//          );
//        }
//    );
//  }
//
//  Future<DocumentReference> _addNewItem() async {
//    final doc =  await firestore.collection(dropdownValue).add({
//      'Title': title,
//      'Type': dropdownValue,
//      'Description': description,
//      'Quantity': number,
//      'Location': point.data,
//      'Weight': weight,
//      'Owner': 'OlRE1Ss0b120Mowy476M',
//      'isReserved': false,
//    });
//    print('done');
//    return doc;
//  }
//
//  Future _updateUserItems(DocumentReference doc) async {
//    var firebaseUser = await FirebaseAuth.instance.currentUser();
//    item = ({'Type': dropdownValue,'Id':doc.documentID});
//    firestore.collection('users').document(firebaseUser.uid).updateData({
//      "Items" : FieldValue.arrayUnion([item]),
//    });
//    _updateItemList();
//  }
//
//
//  ///---------
//
//  void _addLocation() async{
//    var pos = await location.getLocation();
//    GeoFirePoint _point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
//    print(_point.data);
//    setState((){
//      point = _point;
//    });
//  }
//
//  @override
//  void initState() {
//    _updateItemList();
//    print('here');
//    super.initState();
//  }
//}
//
//
//




import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycle/details.dart';
import 'Fruitepage.dart';
import 'home2.dart';
import 'map.dart';
import 'dart:async';
import 'login/login.dart';
import 'login/Sign_up.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rxdart/rxdart.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingExample(),
      routes: {
        "/client_home": (context)=>login(false),
        "/myhome":(context)=>login(true),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  String vendname;
  MyHomePage(this.vendname);
  @override
  _MyHomePageState createState() => _MyHomePageState(vendname);
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String vendname;
  _MyHomePageState(this.vendname);
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 1);
  }
  Location location = new Location();
  Geoflutterfire geo = Geoflutterfire();
  Firestore firestore = Firestore.instance;
  void _addLocation() async{
    var pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    print(point.data);
    /*var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection('users/collectors').document(firebaseUser.uid).setData({
      "Location" : point.data
    }) */
    firestore.collection('users').add({
      'Location': point.data,
      'Name': 'Me',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 10.0, right: 15.0, bottom: 10.0, left: 15.0),
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(
                      Radius.circular(15))
              ),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.5),
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[800],
                    ),
                    border: InputBorder.none,
                    hintText: "Rechercher ... ",
                    hintStyle: TextStyle(
                        color: Colors.grey[500],
                       // fontSize:
                       // ScreenUtil().setSp(30)
                       )
                ),
              ),
            ),
          ),
//        Center(
//          child: Container(
//            margin: EdgeInsets.only(bottom: 8),
//            child: Text("Find Your gategory",
//                style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.grey,)
//            ),
//          ),
//        ),
//        Container(
//        height: 230,
//          padding: EdgeInsets.only(top: 30),
//          width: double.infinity,
//          decoration: BoxDecoration(
//            image:DecorationImage(image: AssetImage("images/vend.png",),fit: BoxFit.fill)
//          ),
//        ),
           GestureDetector(
             onTap: (){
               _addLocation();
             },
             child: Container(
          child: Text("  Gategories",
                style: GoogleFonts.montserrat(fontSize: 28,fontWeight: FontWeight.w400,color: Colors.black87,)
          ),
        ),
           ),
          Container(child: new FruitsPage(vendname)),


//          Padding(
//            padding: EdgeInsets.only(top: 20.0),
//            child: TabBar(
//              controller: tabController,
//              indicatorColor: Colors.transparent,
//              labelColor: Colors.black,
//              unselectedLabelColor: Colors.grey.withOpacity(0.6),
//              isScrollable: true,
//              tabs: <Widget>[
//                Tab(
//                  child: Text(
//                    'mabi3at',
//                    style: TextStyle(
//                        fontSize: 33.0,
//                        fontFamily: 'Montserrat',
//                        fontWeight: FontWeight.bold
//                    ),
//                  ),
//                ),
//                Tab(
//                  child: Text(
//                    'map',
//                    style: TextStyle(
//                        fontSize: 33.0,
//                        fontFamily: 'Montserrat',
//                        fontWeight: FontWeight.bold
//                    ),
//                  ),
//                ),
//                Tab(
//                  child: Text(
//                    'mochtrayati',
//                    style: TextStyle(
//                        fontSize: 33.0,
//                        fontFamily: 'Montserrat',
//                        fontWeight: FontWeight.bold
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),

        ],
      ),
    );
  }
}