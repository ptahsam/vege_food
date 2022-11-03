import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/user.dart';
import 'package:vege_food/auth/auth.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/sharedWidgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController identifier = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoggingIn = false;
  String responseMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context, "");
          },
          child: Icon(
            Icons.close,
            size: 28.0,
            color: Palette.black6,
          ),
        ),
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "images/logo_only.png",
                height: 100.0,
                width: 150.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Login in to VegeFood",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Palette.primaryColor,
                    fontSize: 20.0,
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: Text(
                      "Manage your orders, edit your cart, \nreceive notifications and more.",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0,
                        color: Palette.textColor2
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Palette.greyBorder,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Login with email/phone",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextField(
                          controller: identifier,
                          decoration: InputDecoration(
                            hintText: 'Enter phone/email',
                            hintStyle: TextStyle(
                              color: Palette.black6,
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(
                                  color: Palette.greyBorder,
                                  width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(
                                  color: Palette.primaryColor,
                                  width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter password',
                            hintStyle: TextStyle(
                              color: Palette.black6,
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(
                                color: Palette.greyBorder,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(
                                color: Palette.primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      responseMessage != ""?Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Center(
                          child: Text(
                            responseMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ):SizedBox(height: 10.0,),
                      InkWell(
                        onTap: () async {
                          if(identifier.text.isNotEmpty && password.text.isNotEmpty){
                            setState(() {
                              isLoggingIn = true;
                            });
                            String response = await AssistantMethods.loginUser(context, identifier.text, password.text);
                            if(response == "NOT_REGISTERED"){
                              setState(() {
                                responseMessage = "No account found for the details. Signup first then Login.";
                                isLoggingIn = false;
                                identifier.clear();
                                password.clear();
                              });
                            }else if(response == "PASSWORD_NOT_MATCHED"){
                              setState(() {
                                responseMessage = "Incorrect Password. Enter correct password";
                                isLoggingIn = false;
                                password.clear();
                              });
                            }else if(response == "LOGGED_IN"){
                              User user = Provider.of<AppData>(context, listen: false).user!;
                              saveUserId(user.id!.toString());
                              Navigator.pop(context, "LOGGED_IN");
                            }else{
                              setState(() {
                                isLoggingIn = false;
                              });
                              displayToastMessage("An error occurred. Please try again later.", context);
                            }
                          }else{
                            displayToastMessage("Enter all fields", context);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            "${isLoggingIn?"Logging in...":"Login"}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0,),
                margin: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Palette.greyBorder,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.google,
                    ),
                    SizedBox(width: 10.0,),
                    Text(
                      "Sign in with google",
                      style: TextStyle(
                        color: Palette.black6,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account yet?",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, PageTransition(child: RegisterScreen(), type: PageTransitionType.rightToLeft));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Palette.primaryColor,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

