import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prime_template/features/authentication/views/login_page.dart';
import 'package:prime_template/utils/constants.dart';
import 'package:prime_template/utils/petite_storage.dart';

import '../navigation/views/navigation.dart';

class LocalAuthenticationProvider extends ChangeNotifier {
  dynamic _errorMessage;
  get errorMessage => _errorMessage;
  setErrorMessage(val) {
    _errorMessage = val;

    notifyListeners();
  }

  bool _loading = false;
  get loading => _loading;
  void setIsloading(val) {
    _loading = val;
    notifyListeners();
  }

  void signUp(context) async {
    setIsloading(true);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = credential.user;
      StorageUtil.putString(key: 'user', value: credential.user.toString());
      StorageUtil.putString(key: 'name', value: nameController.text.trim());
      await user?.updateDisplayName(nameController.text.trim());
      StorageUtil.putString(key: 'email', value: emailController.text.trim());
      setIsloading(false);
      showSnack(context, "Account Created Successfully");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Navigation()));
    } on FirebaseAuthException catch (e) {
      setIsloading(false);
      print("has error");
      if (e.code == 'weak-password') {
        setErrorMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setErrorMessage('The account already exists for that email.');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  void loginUser(context) async {
    try {
      setIsloading(true);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      StorageUtil.putString(key: 'user', value: credential.user.toString());

      StorageUtil.putString(key: 'email', value: emailController.text.trim());
      setIsloading(false);
      showSnack(context, "Successfully Logged in");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Navigation()));
    } on FirebaseAuthException catch (e) {
      setIsloading(false);
      print("has error $e");
      if (e.code == 'user-not-found') {
        setErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setErrorMessage('Wrong password provided for that user.');
      }
      setErrorMessage(e.toString());
    }
  }

  void logout(context) async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen())));
    StorageUtil.logout();
  }

//   TextEditingControllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}
