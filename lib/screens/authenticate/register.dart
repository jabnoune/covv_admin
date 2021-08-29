
import 'package:brew_crew_app/services/auth.dart';
import 'package:brew_crew_app/shared/constants.dart';
import 'package:brew_crew_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({ required this.toggleView });
  @override
  _RegisterState createState() => _RegisterState();
}
final _formKey = GlobalKey<FormState>();
class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return   loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                autofocus: true,
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                autofocus: true,
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);

                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}