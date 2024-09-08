import 'package:durga/screens/anotherNewsScreen.dart';
import 'package:durga/screens/eventsPage.dart';
import 'package:durga/screens/homeScreen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.newspaper), label: 'Durga puja'),
        BottomNavigationBarItem(
            icon: Icon(Icons.newspaper), label: 'We want justice'),
        BottomNavigationBarItem(
            icon: Icon(Icons.event_available), label: 'Events'),
      ],
      currentIndex: 0,
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: const Color.fromARGB(255, 143, 141, 141),
      onTap: (index) {
        // Handle navigation
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnotherNewsScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventsScreen()),
            );
            break;
        }
      },
    );
  }
}
