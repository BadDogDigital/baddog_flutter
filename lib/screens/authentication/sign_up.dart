import 'package:baddog_flutter/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:baddog_flutter/models/authentication/login_status_model.dart';
import 'package:baddog_flutter/widgets/authentication/auth_input_field.dart';
import 'package:baddog_flutter/providers/authentication/firebase_authentication.dart';
//https://medium.com/firebase-developers/dive-into-firebase-auth-on-flutter-email-and-link-sign-in-e51603eb08f8

//Email login
//Assume provide this as default and a list of alternatives to join
FirebaseAuth _auth = FirebaseAuth.instance;
GetIt sl = GetIt.instance;
//targeted / secondary firebase app
//FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
//FirebaseAuth auth = FirebaseAuth.instanceFor(app: secondaryApp);

class EmailSignUp extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => _EmailSignUp();
}

class _EmailSignUp extends State<EmailSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _success = false;
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //load login appbar
        title: Text('Sign Up'),
      ),
      body: Form(
        //login body
        //Elsewheres for neat?
        key: _formKey,
        //convinced these should all be individual widgets - as in OUR email field
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AuthInputField(
              controller: _usernameController,
              label: 'Username',
            ),
            AuthInputField(
              controller: _emailController,
              label: 'Email',
            ),
            AuthInputField(
              controller: _passwordController,
              label: 'Password',
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    sl<FirebaseAuthentication>().register(
                      _emailController,
                      _passwordController,
                      _usernameController,
                    );
                    //_register();
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_success
                  ? 'Successfully registered ' + _userEmail
                  : 'Registration failed'),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    child: Text('Already a user?'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text('Sign In'),
                      onPressed: () {
                        //We have login screen already on
                        //we are assuming use though?
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmailSignIn()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    sl<FirebaseAuthentication>().removeListener(_userAuthenticated);
    super.dispose();
  }

  @override
  void initState() {
    sl<FirebaseAuthentication>().addListener(_userAuthenticated);
    //sl<FirebaseAuthentication>().addListener(() => _listener2('Athing'));
    super.initState();
  }

  void _userAuthenticated() {
    setState(() {
      //flash a thing and bounce
      //get user data from Firebase with user id /

      _success = true;
      _userEmail = (sl<FirebaseAuthentication>().email)!;
      Navigator.pop(context);
    });
  }

  /*void _listener() {
    print('We Listened');
    //String pfft = (sl<FirebaseAuthentication>().email)!;
    print('email ' + (sl<FirebaseAuthentication>().email)!);
  }

  void _listener2(str) {
    print('We Listened and got:- ' + str);
    print('email ' + (sl<FirebaseAuthentication>().email)!);
  }

//this is logic layer btw / split out
  void _register() async {
    try {
      //structure seems gross
      sl<LoginModel>().status = Status.Authenticating;
      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user != null) {
        setState(() {
          //flash a thing and bounce
          sl<LoginModel>().status = Status.Authenticated;
          //get user data from Firebase with user id /

          _success = true;
          _userEmail = user.email!;
          Navigator.pop(context);
        });
      } else {
        setState(() {
          _success = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      sl<LoginModel>().status = Status.Unauthenticated;
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      sl<LoginModel>().status = Status.Unauthenticated;
      print(e);
    }
  }*/
}
