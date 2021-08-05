import 'package:flicklist/bloc/change_theme_bloc.dart';
import 'package:flicklist/bloc/change_theme_state.dart';
import 'package:flicklist/screens/login.dart';
import 'package:flicklist/screens/my_flicks.dart';
import 'package:flicklist/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  SettingsPage({this.scaffoldKey});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int option;
  bool isLoggedIn = false;
  final List<Color> colors = [Colors.white, Color(0xff032038), Colors.black];
  final List<Color> borders = [Colors.black, Colors.white, Colors.white];
  final List<String> themes = ['Light', 'Default', 'Dark'];

  @override
  void initState() {
    super.initState();
    Prefs.userName.then((value) {
      if (value.isNotEmpty) {
        setState(() {
          isLoggedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: changeThemeBloc,
      builder: (BuildContext context, ChangeThemeState state) {
        return Theme(
            data: state.themeData,
            child: Container(
              color: state.themeData.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                  backgroundColor: state.themeData.accentColor,
                                  radius: 70,
                                  child: Icon(
                                    Icons.face,
                                    size: 60,
                                    color: state.themeData.primaryColor,
                                  )),
                            ),
                            isLoggedIn
                                ? FlatButton(
                                    onPressed: () {
                                      widget.scaffoldKey.currentState
                                          .openEndDrawer();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyFlicks()));
                                    },
                                    child: Text(
                                      'My FlickList',
                                      style: state.themeData.textTheme.body2,
                                    ),
                                  )
                                : FlatButton(
                                    onPressed: () {
                                      widget.scaffoldKey.currentState
                                          .openEndDrawer();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoginScreen(
                                                    themeData: state.themeData,
                                                  )));
                                    },
                                    child: Text(
                                      'Log In / Sign Up',
                                      style: state.themeData.textTheme.body2,
                                    )),
                            isLoggedIn
                                ? FlatButton(
                                    onPressed: () {
                                      Prefs.clear();
                                      Navigator.pop(context);
                                      widget.scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text('You have been Logged Out.'),
                                        duration: Duration(seconds: 3),
                                      ));
                                    },
                                    child: Text(
                                      'Log Out',
                                      style: state.themeData.textTheme.body2,
                                    ))
                                : SizedBox(height: 10)
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Choose App Theme',
                          style: state.themeData.textTheme.body2,
                        ),
                      ],
                    ),
                    subtitle: SizedBox(
                      height: 100,
                      child: Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 2,
                                                color: borders[index]),
                                            color: colors[index]),
                                      ),
                                    ),
                                    Text(themes[index],
                                        style: state.themeData.textTheme.body2)
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            switch (index) {
                                              case 0:
                                                changeThemeBloc
                                                    .onLightThemeChange();
                                                break;
                                              case 1:
                                                changeThemeBloc
                                                    .onDarkThemeChange();
                                                break;
                                              case 2:
                                                changeThemeBloc
                                                    .onAmoledThemeChange();
                                                break;
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          child: state.themeData.primaryColor ==
                                                  colors[index]
                                              ? Icon(Icons.done,
                                                  color: state
                                                      .themeData.accentColor)
                                              : Container(),
                                        ),
                                      ),
                                    ),
                                    Text(themes[index],
                                        style: state.themeData.textTheme.body2)
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
