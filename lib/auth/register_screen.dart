import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/auth/login_screen.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController identifier = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isRegistering = false;
  String responseMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
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
                  "Sign up for VegeFood",
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
                    "Create a profile, shop for groceries, \nmake orders and more.",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0,
                        color: Palette.textColor1
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
                      "Use phone or email",
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
                      padding: const EdgeInsets.only(top: 10.0,),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextField(
                        controller: confirmPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm password',
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
                        if(identifier.text.isNotEmpty && password.text.isNotEmpty && confirmPassword.text.isNotEmpty){
                          if(password.text == confirmPassword.text){
                            setState(() {
                              isRegistering = true;
                            });
                            String response = await AssistantMethods.registerUser(context, identifier.text, password.text);
                            if(response == "USER_ALREADY_EXISTS"){
                              setState(() {
                                responseMessage = "An account with similar details already exists. Try to login";
                                isRegistering = false;
                              });
                            }else if(response == "UNKNOWN_ERROR" || response == "failed"){
                              setState(() {
                                isRegistering = false;
                              });
                              displayToastMessage("An error occurred. Please try again later.", context);
                            }else{
                              Navigator.pop(context);
                            }
                            //displayToastMessage(response, context);
                          }else{
                            displayToastMessage("Confirm password is incorrect", context);
                          }
                        }else{
                          displayToastMessage("Enter all fields", context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: isRegistering?Palette.primaryColor.withOpacity(0.7):Palette.primaryColor,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Text(
                          "${isRegistering?"Registering...":"Register"}",
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
                      "Sign up with google",
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
                      "Already have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
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
