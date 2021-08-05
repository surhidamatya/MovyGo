import 'package:flicklist/screens/user_update.dart';
import 'package:flicklist/utils/prefs.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  final ThemeData themeData;
  final GlobalKey<ScaffoldState> scaffoldKey;


  UserInfo({this.themeData,this.scaffoldKey});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String _username, _email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Prefs.userEmail.then((emailValue) {
      Prefs.userName.then((usernameValue) {
        setState(() {
          _email = emailValue;
          _username = usernameValue;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 150,
        child: Card(
          color: widget.themeData.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: widget.themeData.accentColor, width: 2)),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: widget.themeData.accentColor,
                  minRadius: 50,
                  child: Icon(
                    Icons.face,
                    color: widget.themeData.cardColor,
                    size: 50,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _username == null ? '...' : _username,
                        style: widget.themeData.textTheme.headline,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _email == null ? '...' : _email,
                        style: widget.themeData.textTheme.caption,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserUpdate(
                                    themeData: widget.themeData,
                                    scaffoldKey: widget.scaffoldKey,
                                  )));
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Edit Profile',
                              style: widget.themeData.textTheme.caption,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.build,
                                color: widget.themeData.accentColor,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
