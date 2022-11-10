import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/user.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';

class SignInGoogle extends StatefulWidget {
  const SignInGoogle({Key? key}) : super(key: key);

  @override
  State<SignInGoogle> createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );

  GoogleSignInAccount? googleSignInAccount;

  Future<void> _handleSignIn() async {
    Future.delayed(Duration(seconds: 0), () async {
      try {
        await _googleSignIn.signIn();
      } catch (error) {
        print(error);
      }
    },);
  }

  updateSignIn() async {
    String res = await AssistantMethods.googleSignIn(context, googleSignInAccount!.displayName??"", googleSignInAccount!.email, googleSignInAccount!.photoUrl??"");
    print(res);
    if(res == "LOGGED_IN"){
      User user = Provider.of<AppData>(context, listen: false).user!;
      saveUserId(user.id!.toString());
      await _googleSignIn.disconnect();
      Navigator.pop(context, "LOGGED_IN");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        googleSignInAccount = account;
      });
      updateSignIn();
    });
    //_googleSignIn.signInSilently();
    super.initState();
    _handleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.center,
          child: Center(
            child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.white,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}
