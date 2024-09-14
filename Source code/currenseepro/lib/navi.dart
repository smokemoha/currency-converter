import 'package:currenseepro/currency.dart';
import 'package:currenseepro/currencylist.dart';
import 'package:currenseepro/exhistory.dart';
import 'package:currenseepro/faq.dart';
import 'package:currenseepro/news.dart';
import 'package:currenseepro/profile.dart';
import 'package:flutter/material.dart';
import 'package:currenseepro/FAQs.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';



class SnakeNavigationBarExampleScreen extends StatefulWidget {
  const SnakeNavigationBarExampleScreen({Key? key}) : super(key: key);

  @override
  _SnakeNavigationBarExampleScreenState createState() =>
      _SnakeNavigationBarExampleScreenState();
}

class _SnakeNavigationBarExampleScreenState
    extends State<SnakeNavigationBarExampleScreen> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    ExchangeRateConverter(),
    ExchangeRateDisplay(),
    ExchangeRateArticlesPage(),
    UserSupportApp(),
    
    Profile(),
  ];

  int _selectedItemPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: Colors.black,
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        padding: const EdgeInsets.only(top: 12),
        snakeViewColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
          _pageController.jumpToPage(index);
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Currency Converter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Exchange Rate History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'User Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _selectedItemPosition = page;
    });
  }
}

