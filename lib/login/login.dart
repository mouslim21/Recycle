import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycle/main.dart';
import '../add_item.dart';
import './animation.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Sign_up.dart';




class login extends StatefulWidget {
  bool a ;
  login(this.a);
  @override
  _loginState createState() => _loginState(a);
}

class _loginState extends State<login> {
  bool a ;
  _loginState(this.a);
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  log(String email , String Password) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: Password);
      FirebaseUser user = result.user;
      setState(() {
        buttonstate = ButtonState.loading;
      });
      return user;
    }catch(e){
      print(e);
      return null;
    }
  }
  Color color = Colors.white;
  var buttonstate =ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
            image: DecorationImage(
              image: AssetImage('images/bgg.png'),
              fit: BoxFit.cover,
            )),


        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3+100,left: 30,right: 30),
                          child: Column(
                            children: <Widget>[
                              FadeAnimation(1.8, Container(
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
                                      height: MediaQuery.of(context).size.height/10,
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                      ),
                                      child: Center(
                                        child: TextField(
                                          style: TextStyle(fontSize: ScreenUtil().setSp(34)),
                                          controller: _email,
                                          keyboardType: TextInputType.emailAddress ,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.email,color: Colors.grey[400],size: MediaQuery.of(context).size.width*0.05),
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(color: Colors.grey[400],fontSize: MediaQuery.of(context).size.width*0.05)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height/10,
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextField(
                                          style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                                          controller: _password,
                                          keyboardType: TextInputType.visiblePassword ,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.lock,color: Colors.grey[400],size: MediaQuery.of(context).size.width*0.05),
                                              border: InputBorder.none,
                                              hintText: "Password",
                                              hintStyle: TextStyle(color: Colors.grey[400],fontSize: MediaQuery.of(context).size.width*0.05)
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                              SizedBox(height: MediaQuery.of(context).size.height/19,),
                              FadeAnimation(2,  ProgressButton.icon(
                                  maxWidth: MediaQuery.of(context).size.width*0.80,
                                  minWidth: MediaQuery.of(context).size.width*0.80,
                                  height: MediaQuery.of(context).size.height*0.07,
                                  textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color: Color(0xff00b76c)),
                                  iconedButtons: {
                                    ButtonState.idle:
                                    IconedButton(
                                      text: "Se connecter",
                                      icon: Icon(Icons.send,color: Color(0xff00b76c),size: MediaQuery.of(context).size.width*0.05),
                                      color: color,
                                    ),
                                    ButtonState.loading:
                                    IconedButton(
                                        text: "Loading",
                                        color: Colors.deepPurple.shade700),
                                    ButtonState.fail:
                                    IconedButton(
                                        text: "échoué".toUpperCase(),
                                        icon: Icon(Icons.cancel,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),
                                        color: Colors.red.shade300),
                                    ButtonState.success:
                                    IconedButton(
                                        text: "Succés".toUpperCase(),
                                        icon: Icon(Icons.check_circle,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),
                                        color: color)
                                  },

                            onPressed:()async{
                              final email = _email.text.toString().trim();
                              final password = _password.text.toString().trim();

                              FirebaseUser user = await log(email , password);

                              if(user != null){
                                print("========================");
                                print(user.displayName);
                                setState(() {
                                  color = Colors.green.shade500;
                                  buttonstate = ButtonState.success;
                                  a?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(email))):
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>jibley_home(email)));
                                });

                              };
                              if(user==null){
                                setState(() {
                                  buttonstate = ButtonState.fail;

                                });
                              }
                            } ,
                                  state: buttonstate),),
                              SizedBox(height: MediaQuery.of(context).size.height/13,),

                              GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)  {
                                      return sign_up(a);}));                                  } ,
                                  child: FadeAnimation(1.5, Container(
                                    padding: EdgeInsets.all(3),
//                              decoration: BoxDecoration(
//                                  border: Border(
//                                    bottom: BorderSide(width: 2,color: Colors.grey)
//                                  ),
//                                  borderRadius: BorderRadius.circular(15)
//                              ),
                                    child: Text("S'inscrire", style: TextStyle(color: Colors.red.shade400,
                                        textBaseline: TextBaseline.alphabetic,
                                        decoration: TextDecoration.underline,
                                        fontSize: MediaQuery.of(context).size.width*0.05
                                      // fontSize: ScreenUtil().setSp(40)
                                    ),
                                    ),
                                  ))),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            )),
      ),
    );
  }
}

