import 'package:flutter/material.dart';
import 'package:wally_app/config/config.dart';
import 'package:wally_app/pages/accountPage.dart';
import 'package:wally_app/pages/explorePage.dart';
import 'package:wally_app/pages/favoritesPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPageIndex = 0 ;
  var _pages = [
    ExplorePage() ,
    FavoritesPage() ,
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WallyApp' , style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green,
      ),
      body: _pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search) ,
            title: Text('Explore')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border) ,
              title: Text('Favorites')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline) ,
              title: Text('Account')
          ),
        ],
        currentIndex: selectedPageIndex,
        onTap: (index) {
          setState(() {
            selectedPageIndex = index ;
          });
        },
      ),
    );
  }
}
