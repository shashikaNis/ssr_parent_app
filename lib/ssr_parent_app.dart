import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssr_parent_app/pages/Route/route.dart';
import 'package:ssr_parent_app/pages/Signup/signup_page.dart';
import 'package:ssr_parent_app/pages/child/child_page.dart';
import 'package:ssr_parent_app/pages/home/home_page.dart';
import 'package:ssr_parent_app/pages/login/login_page.dart';

class SSRParentApp extends StatefulWidget {
  const SSRParentApp({super.key});

  @override
  State<SSRParentApp> createState() => _SSRParentAppState();
}

class _SSRParentAppState extends State<SSRParentApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

     routerConfig: GoRouter(routes: [
       GoRoute(path: '/', builder: (context, state)=> LoginPage()),
       GoRoute(path: '/login', builder: (context, state)=>LoginPage()),
       GoRoute(path: '/register', builder: (context, state)=> SignupPage()),
       GoRoute(path: '/home', builder: (context, state)=> HomePage()),
       GoRoute(path: '/child/:id', builder: (context, state){

         final id = state.pathParameters['id']!;
         return ChildPage(childId: id);
       }),
       GoRoute(path: '/route/:id', builder: (context, state) {

        final id = state.pathParameters['id']!;
        return RoutePage(childId: id);
       }),


     ]),
    );
  }
}
