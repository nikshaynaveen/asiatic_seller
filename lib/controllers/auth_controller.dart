import 'package:asiatic_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Authcontroller extends GetxController {
  var isLoading = false.obs;

  //textcontrollers

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
  }

  //signout method

  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
