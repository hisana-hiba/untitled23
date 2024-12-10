import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/Authentication.dart';
import '../Views/Home.dart';
import 'login.dart';


class Registerpage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Registerpage(
      {super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  late CollectionReference _userDetails;
  bool showPass1 = true;
  bool showPass2 = true;
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    _userDetails = FirebaseFirestore.instance.collection("userDetails");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.white38,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 200),
                  child: Text(
                    "Register to HN!",
                    style: TextStyle(
                        fontSize: 40,
                        // color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140, left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_3),
                      hintText: "Full Name",
                      labelText: "Full Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onSaved: (name) {
                      this.name = name;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      hintText: "Email",
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onSaved: (email) {
                      this.email = email;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextFormField(
                    obscureText: showPass1,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPass1 = !showPass1;
                          });
                        },
                        icon: Icon(
                          showPass1 == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      hintText: "Password",
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onSaved: (password) {
                      this.password = password;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextFormField(
                    obscureText: showPass2,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPass2 = !showPass2;
                          });
                        },
                        icon: Icon(
                          showPass2 == true
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      hintText: "Confirm Password",
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onSaved: (confirmPassword) {
                      this.confirmPassword = confirmPassword;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      if (password != confirmPassword) {
                        Get.snackbar('Error', 'Passwords do not match');
                        return;
                      }

                      // Attempt to sign up the user
                      String? result = await FireHelper()
                          .signUp(mail: email!, password: password!);

                      if (result == null) {
                        await addUserToDB(name!, email!);
                        // Registration successful, navigate to Homepage
                        Get.offAll(() => Home(
                          email: email!,
                          toggleTheme: widget.toggleTheme,
                          isDarkMode: widget.isDarkMode,
                        ));
                      } else {
                        // Show error message if registration failed
                        Get.snackbar('Registration Error', result);
                      }
                    }
                  },
                  child: const Text("Register"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: TextButton(
                      onPressed: () {
                        Get.to(Loginpage(
                          toggleTheme: widget.toggleTheme,
                          isDarkMode: widget.isDarkMode,
                        ));
                      },
                      child: Text('Already have an account? Log in!')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUserToDB(String name, String email) async {
    if (name.isNotEmpty && email.isNotEmpty) {
      await _userDetails.add(
          {'name': name, 'email': email}).then((value) {
        print("User added successfully");

        Navigator.of(context).pop();
      }).catchError((error) {
        print("Failed to add data: $error");
      });
    } else {
      print("Please enter both name and email.");
    }
  }

  Stream<QuerySnapshot> readUser() {
    return _userDetails.snapshots();
  }
}