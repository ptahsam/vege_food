import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/auth/auth.dart';
import 'package:vege_food/config/palette.dart';

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
        title: Text(
          Provider.of<AppData>(context).user!.user_name!,
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

