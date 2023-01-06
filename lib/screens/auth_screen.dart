import 'package:flutter/material.dart';
import '../widgets/form_page.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.75),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Text(
                  'SANAL LİRA',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
          FormPage()
        ],
      ),
    );
  }
}
