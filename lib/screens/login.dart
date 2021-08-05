import 'package:flicklist/models/function.dart';
import 'package:flicklist/screens/landing_screen.dart';
import 'package:flicklist/screens/reset_password.dart';
import 'package:flicklist/screens/signup.dart';
import 'package:flicklist/utils/common_helper.dart';
import 'package:flicklist/utils/prefs.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final ThemeData themeData;

  LoginScreen({this.themeData});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgetPasswordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();
  final _forgotPasswordFromKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _passwordObscureText = true;

  void _passwordObscureTextToggle() {
    setState(() {
      _passwordObscureText = !_passwordObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          'Log In',
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
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
                      child: Text(
                        'Welcome to FlickList',
                        style: widget.themeData.textTheme.headline,
                      ),
                    ),
                    Form(
                      key: _loginFormKey,
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
                                  return 'Email Is required !!!';
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
                                  return 'Password is required';
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
                                        BorderRadius.all(Radius.circular(40.0)),
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
                          if (_loginFormKey.currentState.validate()) {
                            CommonHelper.showProgressBar(context, 'Logging In');
                            makeLoginRequest(emailController.text,
                                    passwordController.text)
                                .then((value) {
                              Prefs.apiToken.then((userApiToken) {
                                if (userApiToken.isNotEmpty) {
                                  if (value == userApiToken) {
                                    Navigator.pop(context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new LandingPage()));
                                  }
                                } else {
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(value),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              });
                            });
                          }
                        },
                        elevation: 11.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Text("Login",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Enter your email to receive reset code.',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(height: 10),
                                        Form(
                                          key: _forgotPasswordFromKey,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Provide a Email';
                                              }
                                              return null;
                                            },
                                            controller:
                                                forgetPasswordController,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 1.0),
                                                ),
                                                hintText: 'Email'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              if (_forgotPasswordFromKey
                                                  .currentState
                                                  .validate()) {
                                                CommonHelper.showProgressBar(
                                                    context, 'Sending Email');
                                                FocusScopeNode currentFocus =
                                                    FocusScope.of(context);
                                                if (!currentFocus
                                                    .hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                                makeForgotPasswordRequest(
                                                        forgetPasswordController
                                                            .text)
                                                    .then((value) {
                                                  if (value
                                                      .startsWith('Token')) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ResetPassword(
                                                                  themeData: widget
                                                                      .themeData,
                                                                  scaffoldKey:
                                                                      _scaffoldKey,
                                                                )));
                                                  } else {
                                                    forgetPasswordController
                                                        .text = '';
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    _scaffoldKey.currentState
                                                        .showSnackBar(SnackBar(
                                                      content: Text(value),
                                                      duration:
                                                          Duration(seconds: 3),
                                                    ));
                                                  }
                                                });
                                              }
                                            },
                                            child: Text(
                                              "Send",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.lightBlue,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text("Forgot your password ?",
                          style: widget.themeData.textTheme.body2),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(30.0),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        color: Colors.lightBlueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen(
                                        themeData: widget.themeData,
                                        scaffoldKey: _scaffoldKey,
                                      )));
                        },
                        elevation: 11.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Text("Register as New User",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
