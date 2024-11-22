

import 'package:flutter/material.dart';

class RoutePage extends StatefulWidget{
  @override
  State<RoutePage> createState() => RawScrollbarState();
}
class RoutePageState extends State<RoutePage>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }
  
}