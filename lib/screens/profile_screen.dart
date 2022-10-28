import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/user.dart';
import 'package:vege_food/auth/auth.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/sharedWidgets/personal_info.dart';
import 'package:vege_food/sharedWidgets/user_address.dart';
import 'package:vege_food/sharedWidgets/view_user_photo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userid = '';

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    checkUserExists();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkUserExists();
  }

  checkUserExists() {
    setState(() async {
      userid = await getUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AppData>(context).user != null?Provider.of<AppData>(context).user!:null;
    return Provider.of<AppData>(context).user != null?Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
            ""
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
                child: user!.user_photo != null?InkWell(
                  onTap: (){
                    Navigator.push(context, PageTransition(child: ViewUserPhoto(user: user,), type: PageTransitionType.rightToLeft));
                  },
                  child: Image.network(
                    "${ApiConstants.baseUrl}/images/profiles/${user.user_photo!}",
                    height: 100.0,
                    width: 100.0,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ):Image.asset(
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
                padding: EdgeInsets.only(top: 20.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    FontAwesomeIcons.user,
                    color: Palette.black6,
                    size: 24.0,
                  ),
                  title: Text(
                    "Personal Information",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Palette.black6
                    ),
                  ),
                  subtitle: Text(
                    "${user!.user_name!}, ${user.user_phone!}, ${user.user_email!}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Palette.textColor1,
                      fontSize: 16.0,
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 28.0,
                    color: Palette.black6,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, PageTransition(child: UserAddress(), type: PageTransitionType.rightToLeft));
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  FontAwesomeIcons.noteSticky,
                  color: Palette.black6,
                  size: 24.0,
                ),
                title: Text(
                  "Order Information",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Palette.black6
                  ),
                ),
                subtitle: Text(
                  "${user.address!.address!}, ${user.address!.county!}, ${user.address!.city}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Palette.textColor1,
                    fontSize: 16.0,
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28.0,
                  color: Palette.black6,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                FontAwesomeIcons.cog,
                color: Palette.black6,
                size: 24.0,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Palette.black6
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 28.0,
                color: Palette.black6,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                FontAwesomeIcons.info,
                color: Palette.black6,
                size: 24.0,
              ),
              title: Text(
                "About",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Palette.black6
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 28.0,
                color: Palette.black6,
              ),
            ),
            InkWell(
              onTap: () async {
                saveUserId('');
                AssistantMethods.getUserData(context, '');
                AssistantMethods.getUserCartItems(context, await getUserId());
                AssistantMethods.getUserOrderItems(context, await getUserId());
                setState(() {

                });
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  FontAwesomeIcons.signOut,
                  color: Palette.black6,
                  size: 24.0,
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Palette.black6
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28.0,
                  color: Palette.black6,
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
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Center(
              child: Container(
                height: 150.0,
                width: 150.0,
                margin: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExtendedAssetImageProvider(
                      "images/profile.jpg",
                    )
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.0,
                    color: Palette.greyBorder,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              "Login or create account to manage your orders, edit your cart items and much more...",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                  color: Palette.textColor1
              ),
            ),
            SizedBox(height: 20.0,),
            InkWell(
              onTap: () async {
                var res = await Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft));
                  if(res == "LOGGED_IN"){
                    AssistantMethods.getUserCartItems(context, await getUserId());
                    AssistantMethods.getUserOrderItems(context, await getUserId());
                  }
                },
              child: Center(
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
          ],
        ),
      ),
    );
  }
}

