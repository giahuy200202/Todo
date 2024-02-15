import 'package:flutter/material.dart';
import 'package:todo/screens/create_screen.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/search_screen.dart';
import 'package:todo/screens/notification_screen.dart';
import 'package:todo/screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/options_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    ref.read(optionsProvider.notifier).setCategoryOption('');
  }

  @override
  Widget build(BuildContext context) {
    // final options = ref.watch(optionsProvider);
    Widget screen = const HomeScreen();

    if (_selectedPageIndex == 0) {
      screen = const HomeScreen();
    } else if (_selectedPageIndex == 1) {
      screen = const SearchScreen();
    } else if (_selectedPageIndex == 2) {
      screen = const CreateScreen();
    } else if (_selectedPageIndex == 3) {
      screen = const NotificationScreen();
    } else if (_selectedPageIndex == 4) {
      screen = const ProfileScreen();
    }

    return Scaffold(
      body: screen,
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
