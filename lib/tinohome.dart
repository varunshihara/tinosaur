import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tinosaur/colors.dart';

import 'pages/categories.dart';
import 'pages/account.dart';
import 'pages/wishlist.dart';
import 'pages/cart.dart';
import 'pages/home.dart';

class MainScreen extends StatefulWidget {
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
// class MainScreen extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    CategoryPage(),
    Wishlist(),
    Cart(),
    Account(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFFFFFFF);

    // var appBar = AppBar(
    //   brightness: Brightness.light,
    //   elevation: 0.0,
    //   titleSpacing: 0.0,
    //   backgroundColor: bgColor,
    //   title: PreferredSize(
    //     preferredSize: Size.fromHeight(100.0), // here the desired height
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.all(10.0),
    //           child: Image.asset(
    //             'assets/images/logo-full.png',
    //             fit: BoxFit.contain,
    //             height: 70,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(100.0), // here the desired height
      //   child: appBar,
      // ),
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text('Store'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text('Wishlist'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: tcDarkBlue,
        unselectedItemColor: tcDarkGreen,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        backgroundColor: tcLightGreen,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
