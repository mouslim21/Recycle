import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:recycle/details.dart';
import 'package:rxdart/rxdart.dart';

class Services extends StatefulWidget {
  String colname;
  Services(this.colname,this.vendname);
  String vendname;
  @override
  _ServicesState createState() => _ServicesState(colname,vendname);
}

class _ServicesState extends State<Services> {
  String colname;
  String vendname;
  _ServicesState(this.colname,this.vendname);
  Location location = new Location();
  GoogleMapController mapController;
  Geoflutterfire geo = Geoflutterfire();
  BehaviorSubject<double> radius = BehaviorSubject.seeded(100.0);
  Stream<dynamic> querry;
  StreamSubscription subscription;
  Firestore firestore = Firestore.instance;
  bool loading = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 3,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(28.000, 3.000), zoom: 3),
            onMapCreated: _onMapCreated,
            myLocationEnabled:
                true, // Add little blue dot for device location, requires permission from user
            mapType: MapType.normal,
            markers: SetOfMarkers,
          ),
          Positioned(
              bottom: 50,
              left: 10,
              child: Slider(
                min: 10.0,
                max: 500.0,
                divisions: 10,
                value: radius.value,
                label: 'Radius ${radius.value}km',
                activeColor: Colors.green,
                inactiveColor: Colors.green.withOpacity(0.2),
                onChanged: _updateQuery,
              )),
          loading ? Center(
            child: CircularProgressIndicator(),
          ): Text('')
        ]));
  }

  Set<Marker> SetOfMarkers = Set();
  static var compteur = 0;
  void _add(double latitude, double longitude, 
      String title, String id, DocumentSnapshot collection,String vendname) {
    var markerIdVal = compteur.toString();
    compteur++;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          snippet: '', title: title,
          onTap: () async {
            print("ggggggggggg");
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(collection,colname,vendname)));
        }
        ),
        );
        setState(() {
      // adding a new marker to map
      SetOfMarkers.add(marker);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    _animateToUser();
    method(colname);
  }

   _animateToUser() async {
    var pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 17.0,
    )));
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    print(documentList);
    SetOfMarkers.clear();
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint pos = document.data['Location']['geopoint'];
      double distance = document.data['distance'];
      _add(pos.latitude, pos.longitude,
          document.data['Title'], document.documentID, document,vendname);
    });
  }

  method(String collection) async {
    setState(() {
      loading = true;
      print('here');
    });
    _startQuery(collection);
  }

  _startQuery(String collection) async {
    // Get users location
    var pos = await location.getLocation();
    double lat = pos.latitude;
    double lng = pos.longitude;

    // Make a referece to firestore
    var ref = firestore.collection(collection);
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);

    setState((){
      loading = false;
    });

    // subscribe to query
    subscription = radius.switchMap((rad) {
      return geo.collection(collectionRef: ref).within(
          center: center, radius: rad, field: 'Location', strictMode: false);
    }).listen(_updateMarkers);
  }

  _updateQuery(value) {
    final zoomMap = {
      100.0: 12.0,
      200.0: 10.0,
      300.0: 7.0,
      400.0: 6.0,
      500.0: 5.0
    };
    final zoom = zoomMap[value];
    mapController.moveCamera(CameraUpdate.zoomTo(zoom));

    setState(() {
      radius.add(value);
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    method(colname);
    super.initState();
  }
}

