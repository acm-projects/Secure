
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:secure/screens/survey/prompt.dart';
import 'package:secure/services/auth.dart';
import 'package:secure/services/database.dart';
import 'package:secure/shared/constants.dart';
import 'package:secure/shared/loading.dart';


class Register2 extends StatefulWidget {

  final Function toggleView;
  Register2({this.toggleView});

  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text field state
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmP  = '';
  String error = '';

  @override
  Widget build(BuildContext context) {



    return loading ? Loading() : Scaffold(

        body: Container(

          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.jpg'),
                  fit: BoxFit.cover
              )
          ),
          constraints: BoxConstraints.expand(),

          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),


          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 500.0,
                          width: 450.0,

                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: new BorderRadius.all (Radius.circular(40.0)),
                              boxShadow: [
                                BoxShadow (
                                  color:Colors.grey[500],
                                  offset: Offset(0.0, 1.5),
                                  blurRadius: 1.5,
                                ),
                              ]
                          ),
                          child: Column(

                              children: <Widget>[
                                SizedBox(height: 70.0),
                                TextFormField(
                                    decoration: textInputDecoration.copyWith(hintText: 'Email'),

                                    validator: (val) => val.isEmpty ? 'Enter your Email address' : null,
                                    onChanged: (val){
                                      setState(() => email = val);
                                    },

                                    keyboardType: TextInputType.emailAddress,
                                    style: new TextStyle(
                                      fontFamily: "Raleway",
                                    )
                                ),
                                SizedBox(height: 30.0),
                                TextFormField(
                                    decoration: textInputDecoration.copyWith(hintText: 'Password'),

                                    validator: (val) => val.isEmpty ? 'Enter your Password' : null,
                                    onChanged: (val){
                                      setState(() => password = val);
                                    },

                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    style: new TextStyle(
                                      fontFamily: "Raleway",
                                    )
                                ),
                                SizedBox(height: 30.0),
                                TextFormField(
                                    decoration: textInputDecoration.copyWith(hintText: 'Confirm Password'),

                                    validator: (val) => val.isEmpty ? 'Please confirm your Password' : null,
                                    onChanged: (val){
                                      setState(() => confirmP = val);
                                    },

                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    style: new TextStyle(
                                      fontFamily: "Raleway",
                                    )
                                ),

                                SizedBox(height: 15.0),
                                RaisedButton(

                                  color: Colors.indigo[700],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(1000.0),
                                      side: BorderSide(color: Colors.indigo[700])
                                  ),
                                  child: Text(
                                      'Sign Up',
                                      style: TextStyle(color: Colors.white)
                                  ),
                                  onPressed: () async {
                                    if(_formKey.currentState.validate()){
                                      setState(() => loading = true);
                                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                                      if (result == null){
                                        setState(() {
                                          error = 'Please Supply Valid Email';
                                          loading = false;
                                        });
                                      }else{
                                        await DatabaseService(uid: result.uid).updateUserData(firstName,lastName);
                                        print('User Account Created');
                                      }
                                    }
                                  },
                                ),
                                SizedBox(height: 15.0),

                                Text(
                                  error,
                                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                                ),
                                RaisedButton(

                                    color: Colors.indigo[700],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(1000.0),
                                        side: BorderSide(color: Colors.indigo[700])
                                    ),
                                    child: Text(
                                        'Survey',
                                        style: TextStyle(color: Colors.white)
                                    ),
                                    onPressed: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Prompt())
                                      );
                                    }
                                )
                              ]
                          )
                      ),
                    ]
                )
            ),
          ),
        )
    );
  }
}