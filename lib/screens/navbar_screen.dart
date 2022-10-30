import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vege_food/Assistants/assistantMethods.dart';
import 'package:vege_food/config/config.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/screens/screens.dart';

import '../sharedWidgets/widgets.dart';

class NavBarScreen extends StatefulWidget {
  static const String idScreen = "NavScreen";
  final bool isNavigate;
  final int navigateIndex;
  const NavBarScreen({
    Key? key,
    this.isNavigate = false,
    this.navigateIndex = 0
  }) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {

  final List<Widget> _screens = [
    HomeScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  List<IconData> _icons = [
   MdiIcons.home,
   Icons.shopping_basket,
   FontAwesomeIcons.user,
  ];

  int _selectedIndex = 0;

  @override
  void didUpdateWidget(covariant NavBarScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    getCartItems();
    getOrderItems();
    getUserData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getOrderItems();
    getCartItems();
    checkIsNavigate();
  }

  void checkIsNavigate(){
    if(widget.isNavigate){
      setState(() {
        _selectedIndex = widget.navigateIndex;
      });
    }
  }

  getUserData() async{
    Future.delayed(Duration.zero,()
    async {
      AssistantMethods.getUserData(context, await getUserId());
    });
  }

  getCartItems() async{
    AssistantMethods.getUserCartItems(context, await getUserId());
  }

  getOrderItems() async{
    AssistantMethods.getUserOrderItems(context, await getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _icons.length,
        child: Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(bottom: 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Palette.greyBorder,
                  width: 1.0,
                )
              )
            ),
            child: CustomTabBar(
              icons: _icons,
              selectedIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
          ),
        ),
    );
  }
}
