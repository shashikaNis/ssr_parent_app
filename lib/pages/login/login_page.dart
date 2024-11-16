import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ssr_parent_app/pages/login/login_service.dart';
import 'package:ssr_parent_app/ssr_parent_app.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static String _email = '';
  static String _password = '';

  static onClickLogin(BuildContext context){
    LoginService.login(_email, _password, context);
  }

  @override
  void initState() {
    // methanin wenne log welada inne kila balan inno
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user != null) {
        context.go('/home');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 10,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/images/ssr_logo.png')),
                SizedBox(height: 35),
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFF65558F),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email', border: OutlineInputBorder(),),
                        onChanged: (value)=> {_email=value},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),),
                        onChanged: (value)=>{_password=value},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: ()=>onClickLogin(context),
                          child: const Text(
                            'Lgin',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF65558F)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Don’t have account? "), TextButton(onPressed: (){context.go('/register');}, child:Text('Create One.'))],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
