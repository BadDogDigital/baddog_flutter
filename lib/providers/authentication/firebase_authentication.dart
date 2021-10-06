import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baddog_flutter/models/authentication/login_status_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:baddog_flutter/providers/user/firestore_user.dart';

GetIt sl = GetIt.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
//FirebaseFirestore _firestore = FirebaseFirestore.instance;

//From what I gather these are FOR a single use
//i.e. WE have chnaged NOT 'this' has changed
class FirebaseAuthentication extends ChangeNotifier {
  LoginModel _model = LoginModel();
  String? _password; //don't store anywhere
  String? _email;
  String? get email => _email;

  void _userAdded() {
    sl<FirestoreUser>().removeListener(_userAdded);
    notifyListeners();
  }

  String _errorCodeCheck(e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else {
      return 'Okay!';
    }
  }

  void register(emailController, passwordController, usernameController) async {
    try {
      //We need to check username against taken usernames
      //or during setup user

      //structure seems gross
      _model.status = Status.Authenticating;
      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;
      //if (user != null) {
      _model.status = Status.Authenticated;
      print('Authenticated');
      _email = user?.email;

      //We need to use set to SET the new user document id with the uid of the created authentication
      sl<FirestoreUser>().addListener(
          _userAdded); //We can just await a return probably cleaner
      sl<FirestoreUser>() //this is really add user / we should different function for return baddoguser
          .setUser(usernameController.text, user!.email, user.uid);
    } on FirebaseAuthException catch (e) {
      //sl<LoginModel>().status = Status.Unauthenticated;
      print('${_errorCodeCheck(e)}');
      _model.status = Status.Unauthenticated;
    } catch (e) {
      _model.status = Status.Unauthenticated;
      print(e);
    }
  }

  void signInWithEmailAndPassword(emailController, passwordController) async {
    //can we final foo = sl<LoginModel>() -- foo.status?
    try {
      _model.status = Status.Authenticating;
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;

      //sl<FirestoreUser>().addListener(_userLoggedIn);
      //sets the user for referencing by the rest
      var bdUser = await sl<FirestoreUser>().createBaddogUser(user?.uid);

      _email = user?.email;
      notifyListeners();

      _model.status = Status.Authenticated;
    } on FirebaseAuthException catch (e) {
      _model.status = Status.Unauthenticated;
      print('${_errorCodeCheck(e)}');
    } catch (e) {
      _model.status = Status.Unauthenticated;
      print(e);
    }
  }
}
