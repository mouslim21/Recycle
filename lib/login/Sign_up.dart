import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../add_item.dart';
import '../main.dart';
import './animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class sign_up extends StatefulWidget {
  bool a;
  sign_up(this.a);
  @override
  _sign_upState createState() => _sign_upState(a);
}

class _sign_upState extends State<sign_up> {
  bool a;
  _sign_upState(this.a);
  TextEditingController _nom = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _confpass = new TextEditingController();

  TextEditingController _address =TextEditingController();
  Color _nomc = Colors.grey.shade400;
  Color _emailc =  Colors.grey.shade400;
  Color _phonec =  Colors.grey.shade400;
  Color _passc =  Colors.grey.shade400;
  Color _confpassc =  Colors.grey.shade400;

  sign(String name,String email,String password  ) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    try{

      AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = name;
      user.updateProfile(info);
      await user.sendEmailVerification();
      return true;
    }catch(e){
      print(e);
    }
//    catch(e){
//      if(e is PlatformException) {
////        if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
////            setState(() {
////            hinttext = "this accounte is already existe";
////            _email.text = "";
////            hintemail = Colors.red.shade600;
////            hintemail2 = Colors.red.shade600;
////            print("dddddddddd$e");
////          });
//        }
//      };
      return false;
    //}
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
            image: DecorationImage(
              image: AssetImage('images/b.png'),
              fit: BoxFit.cover,
            )),


        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    child:  Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(530),left: ScreenUtil().setWidth(60),right: ScreenUtil().setWidth(60)),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(2, Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10)
                                  )
                                ]
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: ScreenUtil().setHeight(120),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                  ),
                                  child: TextField(
                                    style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                    controller: _nom,
                                    onChanged: (value){
                                      setState(() {
                                        _nomc = Colors.grey.shade400;
                                        _emailc =  Colors.grey.shade400;
                                        _phonec =  Colors.grey.shade400;
                                      });
                                    },
                                    onTap: (){
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                    },
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person,color: _nomc),
                                        border: InputBorder.none,
                                        hintText: "Full name",
                                        hintStyle: TextStyle(color: _nomc)
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil().setHeight(120),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                  ),
                                  child: TextField(
                                    style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                    onChanged: (value){
                                      setState(() {
                                        _nomc = Colors.grey.shade400;
                                        _emailc =  Colors.grey.shade400;
                                        _phonec =  Colors.grey.shade400;
                                        _passc =  Colors.grey.shade400;
                                        _confpassc =  Colors.grey.shade400;
                                      });
                                    },
                                    onTap: (){
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                      _passc =  Colors.grey.shade400;
                                      _confpassc =  Colors.grey.shade400;
                                    },
                                    controller: _phone,
                                    keyboardType: TextInputType.phone ,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.phone,color: _phonec),
                                        hintText: "Phone number",
                                        hintStyle: TextStyle(color: _phonec)
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil().setHeight(120),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                  ),
                                  child: TextField(
                                    style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                    onChanged: (value){
                                      setState(() {
                                        _nomc = Colors.grey.shade400;
                                        _emailc =  Colors.grey.shade400;
                                        _phonec =  Colors.grey.shade400;
                                        _passc =  Colors.grey.shade400;
                                        _confpassc =  Colors.grey.shade400;
                                      });
                                    },
                                    onTap: (){
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                      _passc =  Colors.grey.shade400;
                                      _confpassc =  Colors.grey.shade400;
                                    },
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress ,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.email,color: _emailc),
                                        hintText: "Email",
                                        hintStyle: TextStyle(color: _emailc)
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil().setHeight(120),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                  ),
                                  child: TextField(
                                    style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                    onChanged: (value){
                                      setState(() {
                                        _nomc = Colors.grey.shade400;
                                        _emailc =  Colors.grey.shade400;
                                        _phonec =  Colors.grey.shade400;
                                        _passc =  Colors.grey.shade400;
                                        _confpassc =  Colors.grey.shade400;
                                      });
                                    },
                                    onTap: (){
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                      _passc =  Colors.grey.shade400;
                                      _confpassc =  Colors.grey.shade400;
                                    },
                                    controller: _pass,
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword ,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.lock,color: _passc),
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: _passc)
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil().setHeight(120),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                  ),
                                  child: TextField(
                                    style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                    keyboardType: TextInputType.visiblePassword ,
                                    controller: _confpass,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.lock,color:_passc),
                                        hintText: "Confirm password",
                                        hintStyle: TextStyle(color: _passc)
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )),
                          SizedBox(height: ScreenUtil().setHeight(60),),

                          GestureDetector(
                    onTap: ()async{
                      final email = _email.text.toString().trim();
                      final pass = _pass.text.toString().trim();
                      final confpass = _confpass.text.toString().trim();
                      final nom = _nom.text.toString().trim();
                      final phone = _phone.text.toString().trim();
                      final address = _address.text.toString().trim();

                      bool result =false;
                      if(pass == confpass && nom.length > 3 && pass.length >7 && (phone.length==10||phone.length==9) && nom.length>2 ){
                        result = await sign(nom , email , pass);
                      }
//                      else{
//                            setState(() {
//                                hintpassword = Colors.red.shade600;
//                              });
//                            }
//                            if(name.length < 3 ){
//                              hintname = Colors.red.shade600;
//
//                            }
//                            if(email ==null || email ==""){
//                              hintemail = Colors.red.shade600;
//
//                            }
                      if(result){
                        Firestore.instance.collection(email).document(email).setData({
                          "Name":nom,
                          "email":email,
                          "Number":phone,
                          "address":address
                        });
    a?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(email))):
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>jibley_home(email)));

                      }else{
                        setState(() {
                          if(nom.length<3){
                            _nomc = Colors.red;
                          }
                          if(email==null||email=="")_emailc = Colors.red;
                          if(phone.length!=10||phone.length==9)_phonec= Colors.red;
                          if(pass.length<8 ||confpass!=pass){
                            _passc = Colors.red;
                            _confpassc = Colors.red;
                          }
                        });
                      }

                    },
                            child: FadeAnimation(1, Container(
                              height: ScreenUtil().setHeight(100),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                 color: Colors.white
                              ),
                              child: Center(
                                child: Text("Sign up", style: TextStyle(color: Colors.green,fontSize: ScreenUtil().setSp(34) ,fontWeight: FontWeight.bold),),
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
