import 'package:flicklist/models/function.dart';
import 'package:flicklist/utils/common_helper.dart';
import 'package:flutter/material.dart';

class UserUpdate extends StatefulWidget {
  final ThemeData themeData;
  final GlobalKey<ScaffoldState> scaffoldKey;

  UserUpdate({this.themeData, this.scaffoldKey});

  @override
  _UserUpdateState createState() => _UserUpdateState();
}

class _UserUpdateState extends State<UserUpdate> {
  final _updateProfileFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  bool _currentPasswordObscureText = true;
  bool _newPasswordObscureText = true;
  bool _passwordConfirmObscureText = true;

  void _currentPasswordObscureTextToggle() {
    setState(() {
      _currentPasswordObscureText = !_currentPasswordObscureText;
    });
  }

  void _newPasswordObscureTextToggle() {
    setState(() {
      _newPasswordObscureText = !_newPasswordObscureText;
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
            'Update your Profile',
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
                padding: EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
                child: Text(
                  'Change Your Password',
                  style: widget.themeData.textTheme.headline,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _updateProfileFormKey,
                child: Column(
                  children: <Widget>[
                    Card(
                      margin:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      elevation: 11.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter your current Password';
                          }
                          return null;
                        },
                        obscureText: _currentPasswordObscureText,
                        controller: currentPasswordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: _currentPasswordObscureTextToggle,
                              icon: _currentPasswordObscureText
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
                            hintText: "Current Password",
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
                    Card(
                      margin:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      elevation: 11.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter your New Password';
                          }
                          if (value.length < 8) {
                            return 'Password should be more than 8 letters';
                          }
                          return null;
                        },
                        obscureText: _newPasswordObscureText,
                        controller: newPasswordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: _newPasswordObscureTextToggle,
                              icon: _newPasswordObscureText
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
                            hintText: "New Password",
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
                    Card(
                      margin:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      elevation: 11.0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Confirm your new Password';
                          }
                          if (value.length < 8) {
                            return 'Password should be more than 8 letters';
                          }
                          return null;
                        },
                        obscureText: _passwordConfirmObscureText,
                        controller: confirmNewPasswordController,
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
                            hintText: "Confirm new Password",
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
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(30.0),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        color: Colors.blue,
                        onPressed: () {
                          if (_updateProfileFormKey.currentState.validate()) {
                            CommonHelper.showProgressBar(
                                context, 'Updating your Profile');
                            updatePassword(
                                    currentPasswordController.text.trim(),
                                    newPasswordController.text.trim(),
                                    confirmNewPasswordController.text.trim())
                                .then((value) {
                              Navigator.pop(context);
                              if (value.startsWith('Successfully')) {
                                Navigator.pop(context);
                                widget.scaffoldKey.currentState
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Profile Updated. Password Successfully updated.'),
                                  duration: Duration(seconds: 3),
                                ));
                              }
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(value),
                                duration: Duration(seconds: 3),
                              ));
                            });
                          }
                        },
                        elevation: 11.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Text("Apply Changes",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
