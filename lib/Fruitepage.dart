import 'package:flutter/material.dart';

import 'map.dart';

class FruitsPage extends StatefulWidget {
  String vendname;
  FruitsPage(this.vendname);
  @override
  _FruitsPageState createState() => _FruitsPageState(vendname);
}

class _FruitsPageState extends State<FruitsPage> {
  String vendname;
  _FruitsPageState(this.vendname);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            getFoodCard('images/metal-8.png', Colors.yellowAccent, '0.75', true,"Metal",vendname),
            getFoodCard('images/wood-8.png', Colors.brown.withOpacity(0.2), '0.25', true,"Wood",vendname),
            getFoodCard('images/organic-8.png', Colors.blueAccent.withOpacity(0.8), '0.75', true,"Organic",vendname),
            getFoodCard('images/plastic-8.png', Colors.yellowAccent.withOpacity(0.7), '0.25', true,"Plastic",vendname),
            SizedBox(height: 15.0)
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 25.0),
            getFoodCard('images/glass-8.png', Colors.greenAccent, '0.25', true,"Glass",vendname),
            getFoodCard('images/paper-8.png', Colors.lightBlueAccent.withOpacity(0.8), '0.25', false,"Paper",vendname),
            getFoodCard('images/clothes-8.png', Colors.blueGrey.withOpacity(0.3), '0.25', true,"Clothes",vendname),
            getFoodCard('images/other-8.png', Colors.deepPurpleAccent.withOpacity(0.5), '0.25', false,"Other",vendname),
          ],
        )
      ],
    );
  }

  Widget getFoodCard(
      String imgPath, Color fruitName, String price, bool isFav,String name,String vendname) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Services(name,vendname)));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Container(
          height: 200.0,
          width: (MediaQuery.of(context).size.width / 2) - 20.0,
          decoration: BoxDecoration(
              color: fruitName,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2.0,
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2.0
                )
              ]
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 160.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: AssetImage(imgPath),
                              //fit: BoxFit.fill
                          )

                      ),
                    ),
                  ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Align(
//                      alignment: Alignment.topRight,
//                     // child: isFav ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border, color: Colors.red)
//                  ),
//                )
                ],
              ),
              //SizedBox(height: 15.0),
//            Text(fruitName,
//              style: TextStyle(
//                  fontFamily: 'Montserrat',
//                  fontSize: 14.0,
//                  fontWeight: FontWeight.bold
//              ),
//            ),
//
//            Text('\$' + price + ' each',
//              style: TextStyle(
//                  fontFamily: 'Montserrat',
//                  fontSize: 14.0,
//                  color: Colors.grey
//              ),
//            )
            ],
          ),
        ),
      ),
    );
  }
}