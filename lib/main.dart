import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vege_food/DataHandler/appdata.dart';
import 'package:vege_food/config/colorMap.dart';
import 'package:vege_food/config/palette.dart';
import 'package:vege_food/screens/navbar_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context){
        return AppData();
      },
      child: Consumer<AppData>(
        builder: (BuildContext context, value, Widget? child){
          return MaterialApp(
            title: 'VegeFood',
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primarySwatch: MaterialColor(0xFF2DCE89, color),
              textTheme:
              Theme.of(context).textTheme.apply(
                bodyColor: Colors.black, //<-- SEE HERE
                displayColor: Colors.black, //<-- SEE HERE
              ),
            ),
            home: const NavBarScreen(),
            debugShowCheckedModeBanner: false,
            /*routes: {
              "/" : (BuildContext context) => NavBarScreen(),
            },*/
          );
        },
      ),
    );
  }
}
