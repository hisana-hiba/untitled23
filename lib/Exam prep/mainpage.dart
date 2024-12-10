
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled23/Exam%20prep/loginpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAQnKqAV6U9ClLXDa2MW-X5-JYsdNZzglI',
          appId: '1:679194020989:android:39aaf02d03066b35a6f514',
          messagingSenderId: '',
          projectId: 'my-project-574ca',
          storageBucket: 'my-project-574ca.firebasestorage.app'));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,home: Loginpage(),
  ));
}


