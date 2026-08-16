import 'package:evently_c19/core/app_routes/app_routes.dart';
import 'package:evently_c19/modules/main_layout/tabs/favorite/favorite_tab.dart';
import 'package:evently_c19/modules/main_layout/tabs/home/home_tab.dart';
import 'package:evently_c19/modules/main_layout/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    FavoriteTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: tabs[selectedIndex],
        floatingActionButton: buildFab(),
        bottomNavigationBar: buildBottomNavBar());
  }

  Widget? buildBottomNavBar() => BottomNavigationBar(
    onTap: (newIndex){
      selectedIndex = newIndex;
      setState(() {});
    },
    currentIndex: selectedIndex,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Profile"),
    ],
  );

  Widget buildFab() => FloatingActionButton(onPressed: (){
    Navigator.push(context, AppRoutes.addEvent());
  }, child: Icon(Icons.add, color: Colors.white,),
    shape: CircleBorder(),
    backgroundColor: Theme.of(context).primaryColor,);
}
