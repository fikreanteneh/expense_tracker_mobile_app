import 'package:expense_tracker/presentation/home.dart';
import 'package:flutter/material.dart';

class Starting extends StatefulWidget {
  const Starting({Key? key}) : super(key: key);

  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const Home(),
    const Home(),
    const Home(),
    const Home(),

    // const Categories(),
    // const Chart(),
    // const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        unselectedItemColor: Colors.black,
        iconSize: 28,
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 0 ? Colors.blue : Colors.transparent,
                width: bottomBarBorderWidth,
              ))),
              child: const Icon(Icons.home_outlined),
            ),
            label: "Home",
          ),

          // service page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 1 ? Colors.blue : Colors.transparent,
                width: bottomBarBorderWidth,
              ))),
              child: const Icon(Icons.medical_services),
            ),
            label: "Categories",
          ),

          //appointment
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 2 ? Colors.blue : Colors.transparent,
                width: bottomBarBorderWidth,
              ))),
              child: const Icon(Icons.lock_clock),
            ),
            label: "Charts",
          ),

          // profile page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                color: _page == 3 ? Colors.blue : Colors.transparent,
                width: bottomBarBorderWidth,
              ))),
              child: const Icon(Icons.person_outline),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
