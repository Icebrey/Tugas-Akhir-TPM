import 'package:currencyconverter/pages/animal_cross_fossil.dart';
import 'package:currencyconverter/pages/currency_converter.dart';
import 'package:currencyconverter/pages/login.dart';
import 'package:currencyconverter/pages/world_clock.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ProfileScreen(),
    CriticismScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Landing Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Perform logout operation here
              // For simplicity, just navigate to login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'criticism and suggestions',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardMenu(
            title: 'Animal Crossing: New Horizons',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => FossilsList(),
                ),
              );
            },
          ),
          SizedBox(height: 16.0),
          CardMenu(
            title: 'Currency Converter',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CurrencyConverter(),
                ),
              );
            },
          ),
          SizedBox(height: 16.0),
          CardMenu(
            title: 'World Clock',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => WorldClockHomePage(),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.teal,
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/photo.jpg'
                      ),
                      radius: 50,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Bahreisy Hakim',
                      style:
                      TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '123190033',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}

class CriticismScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Teknologi Dan Pemrograman Mobile\nmemberiku banyak pelajaran', textAlign: TextAlign.center,),
    );
  }
}

class CardMenu extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CardMenu({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}