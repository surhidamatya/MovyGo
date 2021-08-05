import 'package:flicklist/bloc/change_theme_bloc.dart';
import 'package:flicklist/bloc/change_theme_state.dart';
import 'package:flicklist/models/function.dart';
import 'package:flicklist/screens/login.dart';
import 'package:flicklist/screens/my_flick_list.dart';
import 'package:flicklist/screens/user_info.dart';
import 'package:flicklist/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFlicks extends StatefulWidget {
  @override
  _MyFlicksState createState() => _MyFlicksState();
}

class _MyFlicksState extends State<MyFlicks> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String verification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyToken().then((value) {
      setState(() {
        verification = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: changeThemeBloc,
        builder: (BuildContext context, ChangeThemeState state) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: state.themeData.primaryColor,
              leading: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: state.themeData.accentColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'My FlickList',
                style: state.themeData.textTheme.headline,
              ),
            ),
            body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        state.themeData.primaryColor,
                        state.themeData.backgroundColor
                      ]),
                ),
                child: ListView(
                  children: <Widget>[
                    UserInfo(
                      themeData: state.themeData,
                      scaffoldKey: _scaffoldKey,
                    ),
                    verification == null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Verifying User... Please wait...',
                              style: state.themeData.textTheme.headline,
                            ),
                          )
                        : verification == 'Success'
                            ? MyFlickList(
                                themeData: state.themeData,
                                scaffoldKey: _scaffoldKey,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      'Your Token has been Expired. \nPlease Login Again to Access your FlickList.',
                                      style: state.themeData.textTheme.caption,
                                    ),
                                    Container(
                                      child: RaisedButton(
                                        color: state.themeData.buttonColor,
                                        onPressed: () {
                                          Prefs.clear();
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      new LoginScreen(
                                                        themeData:
                                                            state.themeData,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Login Again',
                                            style: state
                                                .themeData.textTheme.caption,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                  ],
                )),
          );
        });
  }
}
