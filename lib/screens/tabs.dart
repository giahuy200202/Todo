import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Homepage';

    if (_selectedPageIndex == 1) {
      // activePage = MealsScreen(
      //   meals: _favoriteMeals,
      //   onToggleFavorite: _toggleMealFavoriteStatus,
      // );
      activePageTitle = 'Search';
    } else if (_selectedPageIndex == 2) {
      activePageTitle = 'Notifications';
    } else if (_selectedPageIndex == 3) {
      activePageTitle = 'Your profile';
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          const SizedBox(height: 23),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              activePageTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
        ]),
      ),
      body: const HomeScreen(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0.0,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed, // This is all you need!
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Icon(Icons.home, size: 30),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Icon(Icons.search, size: 30),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 65, color: Colors.black),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Icon(Icons.notifications_active, size: 30),
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 20, right: 20),
              child: Icon(Icons.person, size: 30),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
