import 'package:firebase_auth/firebase_auth.dart';

class FireHelp {
  final FirebaseAuth auth = FirebaseAuth.instance;

  get user => auth.currentUser!;

  Future<String?> signUp({required String mail, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      print(e);
      return "An error occurred";
    }
  }


  Future<String?> signIn(
      {required String emailAddress, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return null;
    }
    on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') {
        print('No user found in this email');
      }
      else if(e.code == 'wrong password') {
        print('Wrong password provided for the user');
      }
      return e.message;
    }
  }
}