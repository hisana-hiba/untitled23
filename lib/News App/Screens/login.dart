import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/Authentication.dart';
import '../Views/Home.dart';
import 'Register.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: const FirebaseOptions(
//           apiKey: "AIzaSyCZMuPlPGeDQ4rAhQkUaN3qB4EBSquWqVI",
//           appId: "1:296013781654:android:0847cadfb677b15b2340b7",
//           messagingSenderId: '',
//           projectId: "fir-app-b2566"));
//
//   runApp(GetMaterialApp(
//     home: Loginpage(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class Loginpage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Loginpage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool hidePass = true;
  bool userFound = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.white54,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 200),
                  child: Text(
                    "Login to HN!",
                    style: TextStyle(
                        fontSize: 40,
                        // color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220, left: 20, right: 20),
                  child: TextFormField(
                    onSaved: (email) {
                      this.email = email;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Email",
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    onSaved: (pass) {
                      this.password = pass;
                    },
                    obscureText: hidePass,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                        icon: Icon(
                          hidePass ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      hintText: "Password",
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 40,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        foregroundColor: Colors.black87),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        FireHelper()
                            .signIn(emailAddress: email!, password: password!)
                            .then((value) {
                          if (value == null) {
                            Get.to(Home(
                              email: email!,
                              toggleTheme: widget.toggleTheme,
                              isDarkMode: widget.isDarkMode,
                            ));
                          } else {
                            Get.snackbar('Error', 'User not found $value');
                          }
                        });
                      }
                    },
                    child: const Text(
                      "Login",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 125),
                  child: TextButton(
                    onPressed: () {
                      Get.to(Registerpage(
                        toggleTheme: widget.toggleTheme,
                        isDarkMode: widget.isDarkMode,
                      ));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white70,
                        foregroundColor: Colors.black87),
                    child: const Text("Create an account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}