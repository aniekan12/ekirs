import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:data_collection/views/mysplash.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1.5,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/wifi.png'),
              ),
            ),
          ),
          Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "You're not connected to the internet. Make sure your mobile data or wifi is on.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
