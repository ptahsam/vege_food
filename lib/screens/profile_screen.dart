import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/auth/auth.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/sharedWidgets/personal_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    //checkUserExists();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkUserExists();
  }

  checkUserExists(){
    Future.delayed(Duration.zero,()
    async {
      Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<AppData>(context).user != null?Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          Provider.of<AppData>(context).user!.user_name!,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: Image.asset(
                  "images/profile.jpg",
                  height: 100.0,
                  width: 100.0,
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, PageTransition(child: PersonalInfo(), type: PageTransitionType.rightToLeft));
              },
              child: Container(
                padding: EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.user,
                          color: Palette.black6,
                          size: 24.0,
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Palette.black6
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 28.0,
                      color: Palette.black6,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.noteSticky,
                        color: Palette.black6,
                        size: 24.0,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        "Order Information",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Palette.black6
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 28.0,
                    color: Palette.black6,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.cog,
                        color: Palette.black6,
                        size: 24.0,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Palette.black6
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 28.0,
                    color: Palette.black6,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.info,
                        color: Palette.black6,
                        size: 24.0,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        "About",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Palette.black6
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 28.0,
                    color: Palette.black6,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                saveUserId('');
                AssistantMethods.getUserData(context, '');
                setState(() {

                });
              },
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.signOut,
                          color: Palette.black6,
                          size: 24.0,
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Palette.black6
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 28.0,
                      color: Palette.black6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ):Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.center,
          child: Center(
            child: InkWell(
              onTap: (){
                Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                padding: EdgeInsets.symmetric(vertical: 12.0,),
                decoration: BoxDecoration(
                  color: Palette.primaryColor,
                ),
                child: Text(
                  "Login or Signup",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

