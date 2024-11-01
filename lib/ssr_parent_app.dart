import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssr_parent_app/pages/home/home_page.dart';

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
       GoRoute(path: '/', builder: (context, state)=> HomePage()),
       GoRoute(path: 'login', builder: (context, state)=> Text("login")),
       GoRoute(path: 'register', builder: (context, state)=> Text("register"))
     ]),
    );
  }
}
