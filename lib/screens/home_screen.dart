import 'package:aistcargo/screens/home_tab.dart';
import 'package:aistcargo/screens/profile_tab.dart';
import 'package:aistcargo/screens/search_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    const HomeTab(),
    const SearchTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedTabIndex == 2
          ? AppBar(
              title: const Text('Профиль'),
            )
          : null,
      body: _pages.elementAt(_selectedTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabChanged,
        currentIndex: _selectedTabIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
