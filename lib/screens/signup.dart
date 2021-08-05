import 'package:flicklist/models/function.dart';
import 'package:flicklist/screens/login.dart';
import 'package:flicklist/utils/common_helper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final ThemeData themeData;
  final GlobalKey<ScaffoldState> scaffoldKey;

  SignUpScreen({this.themeData, this.scaffoldKey});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _signupFormKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool _passwordObscureText = true;
  bool _passwordConfirmObscureText = true;

  void _passwordObscureTextToggle() {
    setState(() {
      _passwordObscureText = !_passwordObscureText;
    });
  }

  void _passwordConfirmObscureTextToggle() {
    setState(() {
      _passwordConfirmObscureText = !_passwordConfirmObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: widget.themeData.primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: widget.themeData.accentColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Sign Up',
          style: widget.themeData.textTheme.headline,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                widget.themeData.primaryColor,
                widget.themeData.accentColor
              ]),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
                    child: Text(
                      'Join FlickList',
                      style: widget.themeData.textTheme.headline,
                    ),
                  ),
                  Form(
                    key: _signupFormKey,
                    child: Column(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 30.0),
                          elevation: 11.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Provide a Username';
                              }
                              return null;
                            },
                            controller: userNameController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black26,
                                ),
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.black26),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 30.0),
                          elevation: 11.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Provide a Email';
                              }
                              return null;
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black26,
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.black26),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 20.0),
                          elevation: 11.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Provide a password';
                              }
                              if(value.length < 8){
                                return 'Password should be more than 8 letters';
                              }
                              return null;
                            },
                            obscureText: _passwordObscureText,
                            controller: passwordController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: _passwordObscureTextToggle,
                                  icon: _passwordObscureText
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Colors.black26,
                                        )
                                      : Icon(Icons.visibility),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black26,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 20.0),
                          elevation: 11.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Provide a confirm password';
                              }
                              if(value.length < 8){
                                return 'Password should be more than 8 letters';
                              }
                              return null;
                            },
                            obscureText: _passwordConfirmObscureText,
                            controller: passwordConfirmController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: _passwordConfirmObscureTextToggle,
                                  icon: _passwordConfirmObscureText
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Colors.black26,
                                        )
                                      : Icon(Icons.visibility),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black26,
                                ),
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30.0),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      color: Colors.blue,
                      onPressed: () {
                        if (_signupFormKey.currentState.validate()) {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          CommonHelper.showProgressBar(
                              context, 'Creating your profile...');
                          makeSignupRequest(
                                  userNameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  passwordConfirmController.text)
                              .then((value) {
                            if (value.startsWith('Registered')) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              widget.scaffoldKey.currentState
                                  .showSnackBar(SnackBar(
                                content: Text(value),
                                duration: Duration(seconds: 5),
                              ));
                            } else {
                              Navigator.pop(context);
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(value),
                                duration: Duration(seconds: 3),
                              ));
                            }
                          });
                        }
                      },
                      elevation: 11.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
                      child: Text("Register",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Already Registered ? Goto Login.",
                        style: widget.themeData.textTheme.body2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
