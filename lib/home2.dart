import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class PageData {
  final String title;
  final String image;
  final Color bgColor;
  final Color textColor;
  final Color bouton;
  final String pagename ;
  PageData({
    this.title,
    this.image,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    this.bouton = Colors.black ,
    this.pagename,
  });
}

class OnboardingExample extends StatelessWidget {
  final List<PageData> pages = [
    PageData(
        pagename: "/client_home",
        image: "images/client.png",
        title: "Got things to recycle?",
      bgColor: Color(0xff4A9475),
      textColor: Colors.white,
      bouton: Colors.white
    ),
    PageData(
        image: "images/vendeur.png",
      pagename: "/myhome",
      title: "Are you collector?",
      bgColor:Color(0xff00b76c),
      textColor: Colors.white,
      bouton: Colors.white

    ),

  ];

  List<Color> get colors => pages.map((p) => p.bgColor).toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: ConcentricPageView(
            colors: colors,
            opacityFactor: 1.0,
            scaleFactor: 0.0,
            radius: 500,
            curve: Curves.ease,
            duration: Duration(seconds: 2),
            verticalPosition: 0.7,
            direction: Axis.vertical,
//          itemCount: pages.length,
//          physics: NeverScrollableScrollPhysics(),
            itemBuilder: (index, value) {
              PageData page = pages[index % pages.length];
              // For example scale or transform some widget by [value] param
              //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
              return Container(
                child: Theme(
                  data: ThemeData(
                    textTheme: TextTheme(
                      title: GoogleFonts.montserrat(
                        color: page.textColor,
                        fontSize: MediaQuery.of(context).size.width*0.06,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                      ),
//                      TextStyle(
//                        color: page.textColor,
//                        fontWeight: FontWeight.w600,
//                        fontFamily: 'Helvetica',
//                        letterSpacing: 0.0,
//                        fontSize: 36,
//                      ),
                      subtitle: TextStyle(
                        color: page.textColor,
                        fontWeight: FontWeight.w300,
                        fontSize: MediaQuery.of(context).size.width*0.06,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      PageCard(page: page),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          onPressed: (){
                            Navigator.of(context).pushNamed("${page.pagename}");
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height/14,
                            width: MediaQuery.of(context).size.width/2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15)
                              )
                            ),
                            child: Center(
                              child: Text("Start",style:
                              TextStyle(fontSize:MediaQuery.of(context).size.width*0.06,color:Colors.white ),),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text("Change profil",
                          style:GoogleFonts.acme(
                            color: page.textColor,
                            fontSize: MediaQuery.of(context).size.width*0.09,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.0,
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  final PageData page;

  const PageCard({
    Key key,
    @required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildPicture(context),
        //  SizedBox(height: MediaQuery.of(context).size.height/12),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      page.title,
      style:GoogleFonts.acme(
        color: page.textColor,
        fontSize:MediaQuery.of(context).size.width*0.09,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPicture(
      BuildContext context,
      ) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image(
            height: MediaQuery.of(context).size.height/2-20,
            width: MediaQuery.of(context).size.width*1.5,
            fit: BoxFit.fitWidth,
            image: AssetImage("${page.image}"
            ),
          )
        ],

      ),
    );
  }
}
