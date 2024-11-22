import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssr_parent_app/service/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  onclickRegister() {
    AuthService.register(emailcontroller.text, passwordcontroller.text,
        phonenumbercontroller.text, fullnamecontroller.text);
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        context.go("/home");
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/ssr_logo.png"),
                ),
                Text(
                  "Register",
                  style: TextStyle(fontSize: 30),
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        controller: emailcontroller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          border: OutlineInputBorder(),
                        ),
                        controller: fullnamecontroller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(),
                        ),
                        controller: phonenumbercontroller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        controller: passwordcontroller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(),
                        ),
                        controller: confirmpasswordcontroller,
                      ),
                      SizedBox(width: double.infinity,child: ElevatedButton(
                        onPressed: onclickRegister,
                        child: const Text("Register", style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF65558F)
                        ),
                      ),)
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go("/login");
                  },
                  child: Text("Allready have account?Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
