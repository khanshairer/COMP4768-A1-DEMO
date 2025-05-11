import 'package:flutter/material.dart';
import 'views/pig_latin.dart'; // Note: snake_case naming
import 'views/postal_code.dart';
import 'views/gpa_calculator.dart';
import 'views/zoo_admission.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miscellaneous App by Sharier Khan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainWrapper(), // New wrapper widget
    );
  }
}

class MainWrapper extends StatefulWidget {
  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  int _totalTickets = 0;
  int _totalCost = 0;

  final List<Widget> _pages = [
    ZooAdmission(), // Moved admission logic here
    PostalCode(),
    GpaCalculator(),
    PigLatin(),
  ];

  void _updateTicketCount(int cost) {
    setState(() {
      _totalTickets++;
      _totalCost += cost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[800],
        height: kBottomNavigationBarHeight + 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavIcon(0, 'assets/images/zoo.png'),
            _buildNavIcon(1, 'assets/images/envelope.png'),
            _buildNavIcon(2, 'assets/images/star.png'),
            _buildNavIcon(3, 'assets/images/globe.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(int index, String iconPath) {
    return IconButton(
      icon: Image.asset(
        iconPath,
        width: 40,
        height: 40,
        color: _currentIndex == index ? Colors.amber[200] : Colors.white,
      ),
      onPressed: () => setState(() => _currentIndex = index),
    );
  }
}
