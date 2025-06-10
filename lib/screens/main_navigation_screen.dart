import 'package:flutter/material.dart';
import 'package:learn_grow_app/screens/home_screen.dart';
import 'package:learn_grow_app/screens/course_list_screen.dart';
import 'package:learn_grow_app/screens/productivity_hub_screen.dart';
import 'package:learn_grow_app/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // List of screens to navigate between
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CourseListScreen(),
    ProductivityHubScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            activeIcon: Icon(Icons.school),
            label: 'Cursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl_outlined),
            activeIcon: Icon(Icons.checklist_rtl),
            label: 'Produtividade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        // Use theme colors
        // selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        // unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        // backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        showUnselectedLabels: true,
      ),
    );
  }
}
