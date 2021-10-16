import 'package:data_collection/util/colors.dart';
import 'package:data_collection/views/banner.dart';
import 'package:flutter/material.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bannertwo.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _email;
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
    });
  }

  @override
  void initState() {
    _loadCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      if (index == 0) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Dashboard()));
      } else if (index == 1) {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => EnumerationPage()));
      } else {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => ProfilePage()));
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello 😀,',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$_email',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 24,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 36),
                  DataBanner(),
                  SizedBox(height: 10),
                  BannerTwo(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: buttonColorTwo,
        selectedLabelStyle: TextStyle(
          fontSize: 16,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                CarbonIcons.home,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Icon(
                CarbonIcons.time,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          // BottomNavigationBarItem(
          //   label: '',
          //   icon: Container(
          //     padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          //     child: Icon(
          //       CarbonIcons.logout,
          //       color: Colors.white,
          //       size: 24,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
