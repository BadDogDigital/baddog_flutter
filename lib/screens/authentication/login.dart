import 'package:baddog_flutter/screens/authentication/sign_up.dart';
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

class EmailSignIn extends StatefulWidget {
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => _EmailSignIn();
}

class _EmailSignIn extends State<EmailSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success = false;
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //load login appbar
        title: Text('Sign In'),
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
                    //_signInWithEmailAndPassword();
                    sl<FirebaseAuthentication>().signInWithEmailAndPassword(
                      _emailController,
                      _passwordController,
                    );
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_success
                  ? 'Successfully signed in ' + _userEmail
                  : 'Sign in failed'),
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    child: Text('Not created an account?'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text('Sign Up'),
                      onPressed: () {
                        //We have login screen already on
                        //we are assuming use though?
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailSignUp(),
                          ),
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
  void initState() {
    sl<FirebaseAuthentication>().addListener(_userAuthenticated);
    //sl<FirebaseAuthentication>().addListener(() => _listener2('Athing'));
    super.initState();
  }

  //this is where we need our checks?
  //Some checks for display err nerr
  void _userAuthenticated() {
    setState(() {
      //flash a thing and bounce
      //get user data from Firebase with user id /

      _success = true;
      _userEmail = (sl<FirebaseAuthentication>().email)!;
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    sl<FirebaseAuthentication>().removeListener(_userAuthenticated);
    super.dispose();
  }

//we need this in a service layer and listen to changes/actions from it to update state
  /*void _signInWithEmailAndPassword() async {
    //can we final foo = sl<LoginModel>() -- foo.status?
    sl<LoginModel>().status = Status.Authenticating;
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    //Use Uid to get stored user data from Firebase and initialise User State
    print('User ID ' + user!.uid);
    //Would be setup User State
    //print('User IName '+ user.displayName);
    if (user != null) {
      //we need try error catch
      setState(() {
        _success = true;
        _userEmail = (user.email)!;
        //print('Authenticated = ' + sl<LoginModel>().status.toString());
        sl<LoginModel>().status = Status.Authenticated;
        //print('Authenticated = ' + sl<LoginModel>().status.toString());
        Navigator.pop(context);
      });
    } else {
      setState(() {
        sl<LoginModel>().status = Status.Unauthenticated;
        _success = false;
      });
    }
  }*/
}
