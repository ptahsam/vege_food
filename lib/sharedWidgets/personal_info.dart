import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/apiConstants.dart';
import 'package:vege_food/Models/user.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/sharedWidgets/view_user_photo.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  bool isEditingName = false;
  bool isEditingPhone = false;
  bool isEditingEmail = false;
  bool isEdit = false;

  File? userSelectedFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTextEditingController.addListener(editUserName);
    phoneTextEditingController.addListener(editUserPhone);
    emailTextEditingController.addListener(editUserEmail);
  }

  void editUserName(){
    if(nameTextEditingController.text.isNotEmpty){
      setState(() {
        isEditingName = true;
      });
    }else{
      setState(() {
        isEditingName = false;
      });
    }
  }

  void editUserPhone(){
    if(phoneTextEditingController.text.isNotEmpty){
      setState(() {
        isEditingPhone = true;
      });
    }else{
      setState(() {
        isEditingPhone = false;
      });
    }
  }

  void editUserEmail(){
    if(emailTextEditingController.text.isNotEmpty){
      setState(() {
        isEditingEmail = true;
      });
    }else{
      setState(() {
        isEditingEmail = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTextEditingController.dispose();
    phoneTextEditingController.dispose();
    emailTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AppData>(context).user!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 12.0),
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            expandedHeight: 170.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: 170.0,
                    decoration: BoxDecoration(
                      color: Palette.primaryColor.withOpacity(0.7),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 12.0,
                    child: Stack(
                      children: [
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.accentColor,
                            border: Border.all(
                              width: 2.0,
                              color: Colors.white,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: user.user_photo != null?InkWell(
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
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ):Image.asset(
                              "images/profile.jpg",
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                                ),
                                context: context,
                                builder: (context) => buildSelectSheet(),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.primaryColor,
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: user.user_photo != null?Icon(
                                Icons.edit,
                                color: Colors.white,
                              ):Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 12.0,
                    bottom: 10.0,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                      child: Icon(
                        Icons.edit,
                        size: 28.0,
                        color: isEdit?Palette.primaryColor:Palette.black6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Fullname",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: !isEdit?Text(
                      user.user_name != ""?user.user_name!:"No name",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Palette.textColor1,
                      ),
                    ):TextField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        hintText: user.user_name!= ""?user.user_name:'Add your name',
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.textColor1,
                        ),
                      ),
                    ),
                    trailing: isEditingName?InkWell(
                      onTap: () async {
                        String res = await AssistantMethods.updateUserDetails(context, "user_name", nameTextEditingController.text, await getUserId());
                        if(res == "SUCCESSFULLY_UPDATED"){
                          AssistantMethods.getUserData(context, await getUserId());
                          setState(() {
                            isEditingName = false;
                            isEdit = false;
                          });
                        }else{
                          displayToastMessage("An error occured. Please try again later", context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Palette.primaryColor,
                          borderRadius: BorderRadius.circular(2.0)
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ):SizedBox.shrink(),
                  ),
                  ListTile(
                    title: Text(
                      "Mobile phone number",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                      ),
                    ),
                    subtitle: !isEdit?Text(
                      user.user_phone != ""?user.user_phone!:"No mobile phone number",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.textColor1,
                      ),
                    ):TextField(
                      controller: phoneTextEditingController,
                      decoration: InputDecoration(
                        hintText: user.user_phone!= ""?user.user_phone:'Add mobile phone number',
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.textColor1,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    trailing: isEditingPhone?InkWell(
                      onTap: () async {
                        String res = await AssistantMethods.updateUserDetails(context, "user_phone", phoneTextEditingController.text, await getUserId());
                        if(res == "SUCCESSFULLY_UPDATED"){
                          AssistantMethods.getUserData(context, await getUserId());
                          setState(() {
                            isEditingPhone = false;
                            isEdit = false;
                          });
                        }else{
                          displayToastMessage("An error occured. Please try again later", context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            borderRadius: BorderRadius.circular(2.0)
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ):SizedBox.shrink(),
                  ),
                  ListTile(
                    title: Text(
                      "Email address",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                      ),
                    ),
                    subtitle: !isEdit?Text(
                      user.user_email != ""?user.user_email!:"No email address",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.textColor1,
                      ),
                    ):TextField(
                      controller: emailTextEditingController,
                      decoration: InputDecoration(
                        hintText: user.user_email!= ""?user.user_email:'Add email address',
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.textColor1,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    trailing: isEditingEmail?InkWell(
                      onTap: () async {
                        String res = await AssistantMethods.updateUserDetails(context, "user_email", emailTextEditingController.text, await getUserId());
                        print(res);
                        if(res == "SUCCESSFULLY_UPDATED"){
                          AssistantMethods.getUserData(context, await getUserId());
                          setState(() {
                            isEditingEmail = false;
                            isEdit = false;
                          });
                        }else{
                          displayToastMessage("An error occured. Please try again later", context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            borderRadius: BorderRadius.circular(2.0)
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ):SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUploadSheet() {
    return Container(
      padding: const EdgeInsets.only(left: 12.0, top: 30.0, right: 12.0, bottom: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Upload profile photo",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.0,),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(
                userSelectedFile!,
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    String res = await AssistantMethods.uploadUserProfile(userSelectedFile!);
                    print(res);
                    if(res == "SUCCESSFULLY_UPDATED"){
                      AssistantMethods.getUserData(context, await getUserId());
                      Navigator.pop(context);
                    }else{
                      displayToastMessage("An error occured. Please try again later.", context);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                    ),
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      userSelectedFile = null;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Text(
                      "Discard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectSheet() {
    return Container(
      padding: const EdgeInsets.only(left: 12.0, top: 30.0, right: 12.0, bottom: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a profile photo",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200]!,
                  shape: BoxShape.circle
                ),
                child: Icon(
                  MdiIcons.camera,
                  color: Palette.primaryColor,
                ),
              ),
              SizedBox(width: 40.0,),
              InkWell(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'svg', 'webp'],
                      allowMultiple: false,
                      allowCompression: true
                  );
                  if(result != null){
                    File file = File(result.files.single.path!);
                    setState(() {
                      userSelectedFile = file;
                    });
                    Navigator.pop(context);
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                      ),
                      context: context,
                      builder: (context) => buildUploadSheet(),
                    );
                  }
                },
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[200]!,
                      shape: BoxShape.circle
                  ),
                  child: Icon(
                    MdiIcons.fileUpload,
                    color: Palette.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
