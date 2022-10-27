import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/Models/user.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({Key? key}) : super(key: key);

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {

  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController countyTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  bool isEdit = false;
  bool isEditingAddress = false;
  bool isEditingCounty = false;
  bool isEditingCity = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressTextEditingController.addListener(editAddress);
    countyTextEditingController.addListener(editCounty);
    cityTextEditingController.addListener(editCity);
  }

  void editAddress(){
    if(addressTextEditingController.text.isNotEmpty){
      setState(() {
        isEditingAddress = true;
      });
    }else{
      setState(() {
        isEditingAddress = false;
      });
    }
  }

  void editCounty(){
    if(countyTextEditingController.text.isNotEmpty){
      setState(() {
        isEditingCounty = true;
      });
    }else{
      setState(() {
        isEditingCounty = false;
      });
    }
  }

  void editCity(){
    if(cityTextEditingController.text.isNotEmpty){
      setState(() {
        isEditingCity = true;
      });
    }else{
      setState(() {
        isEditingCity = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressTextEditingController.dispose();
    countyTextEditingController.dispose();
    cityTextEditingController.dispose();
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
            title: Text(
              "Address Details",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            centerTitle: false,
            expandedHeight: 170.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: 170.0,
                    decoration: BoxDecoration(
                      color: Palette.orange1.withOpacity(0.7),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 12.0,
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1.0,
                          color: Palette.orange1,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Icon(
                        FontAwesomeIcons.addressCard,
                        size: 38.0,
                        color: Palette.orange1,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12.0,
                    bottom: 0.0,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isEdit = !isEdit;
                        });
                      },
                      child: Icon(
                        Icons.edit,
                        size: 28.0,
                        color: isEdit?Palette.orange1:Palette.black6,
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
                      "Delivery Address",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: !isEdit?Text(
                      user.address!.address != ""?user.address!.address!:"No delivery address",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Palette.textColor1,
                      ),
                    ):TextField(
                      controller: addressTextEditingController,
                      decoration: InputDecoration(
                        hintText: user.address!.address != ""?user.address!.address!:'Add delivery address',
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.textColor1,
                        ),
                      ),
                    ),
                    trailing: isEditingAddress?InkWell(
                      onTap: () async {
                        String res = await AssistantMethods.updateUserAddress(context, "address", addressTextEditingController.text, await getUserId());
                        if(res == "SUCCESSFULLY_UPDATED"){
                          AssistantMethods.getUserData(context, await getUserId());
                          setState(() {
                            isEditingAddress = false;
                            isEdit = false;
                          });
                        }else{
                          displayToastMessage("An error occured. Please try again later", context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Palette.orange1,
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
                      "State/Region/County",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: !isEdit?Text(
                      user.address!.county != ""?user.address!.county!:"No region specified",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Palette.textColor1,
                      ),
                    ):TextField(
                      controller: countyTextEditingController,
                      decoration: InputDecoration(
                        hintText: user.address!.county!= ""?user.address!.county!:'Add state/region/county',
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.textColor1,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    trailing: isEditingCounty?InkWell(
                      onTap: () async {
                        String res = await AssistantMethods.updateUserAddress(context, "county", countyTextEditingController.text, await getUserId());
                        if(res == "SUCCESSFULLY_UPDATED"){
                          AssistantMethods.getUserData(context, await getUserId());
                          setState(() {
                            isEditingCounty = false;
                            isEdit = false;
                          });
                        }else{
                          displayToastMessage("An error occured. Please try again later", context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Palette.orange1,
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
                      "City",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: !isEdit?Text(
                      user.address!.city != ""?user.address!.city!:"No city specified",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Palette.textColor1,
                      ),
                    ):TextField(
                      controller: cityTextEditingController,
                      decoration: InputDecoration(
                        hintText: user.address!.city!= ""?user.address!.city!:'Add city',
                        hintStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.textColor1,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    trailing: isEditingCity?InkWell(
                      onTap: () async {
                        String res = await AssistantMethods.updateUserAddress(context, "city", cityTextEditingController.text, await getUserId());
                        if(res == "SUCCESSFULLY_UPDATED"){
                          AssistantMethods.getUserData(context, await getUserId());
                          setState(() {
                            isEditingCity = false;
                            isEdit = false;
                          });
                        }else{
                          displayToastMessage("An error occured. Please try again later", context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        decoration: BoxDecoration(
                            color: Palette.orange1,
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
}
