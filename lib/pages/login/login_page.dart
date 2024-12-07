import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ssr_parent_app/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool isPasswordHidden = true;

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

  onclickLogin() {
    AuthService.login(emailController.text, PasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(40),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/ssr_logo.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Login",
                style:TextStyle(fontSize: 30,color:Color(0xFF65558F)),
              ),
              SizedBox(
                height: 100,
              ),
              Form(
                child: Column(

                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        }, icon: Icon(isPasswordHidden? Icons.visibility: Icons.visibility_off))
                      ),
                      controller: PasswordController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onclickLogin,
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF65558F)),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  context.go("/register");
                },
                child: const Text("Don't have account? Create one"),
              )
            ],
          ),
        )),
      ),
    );
  }
}
