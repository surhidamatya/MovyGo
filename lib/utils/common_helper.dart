import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonHelper {
  static showProgressBar(BuildContext context, String message) {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
          width: 50.0,
          height: 80.0,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: Column(
            children: <Widget>[
              Text(message),
              SizedBox(
                height: 20.0,
              ),
              CircularProgressIndicator(),
            ],
          )),
    );
    showDialog(
      context: context,
      builder: (context) {
        return dialog;
      },
    );
  }

  static longPressAlert(BuildContext context) {
    Widget markAsNotCompletedButton = FlatButton(
      child: Text("Not Completed"),
      onPressed: () {},
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {},
    );

    AlertDialog optionsDialog = new AlertDialog(
      title: Text('Options'),
      content: Text(
          'Please choose your options to perform Actions. You can delete your Flicks or Mark them as Not Completed from here.'),
      actions: <Widget>[markAsNotCompletedButton, cancelButton, deleteButton],
    );
    showDialog(
      context: context,
      builder: (context) {
        return optionsDialog;
      },
    );
  }
}
