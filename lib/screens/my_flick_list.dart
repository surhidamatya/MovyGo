import 'package:flicklist/bloc/change_theme_bloc.dart';
import 'package:flicklist/bloc/change_theme_state.dart';
import 'package:flicklist/constants/api_constants.dart';
import 'package:flicklist/models/flicks.dart';
import 'package:flicklist/models/function.dart';
import 'package:flicklist/screens/user_flick_details.dart';
import 'package:flicklist/utils/common_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyFlickList extends StatefulWidget {
  final ThemeData themeData;
  final GlobalKey<ScaffoldState> scaffoldKey;

  MyFlickList({this.themeData, this.scaffoldKey});

  @override
  _MyFlickListState createState() => _MyFlickListState();
}

class _MyFlickListState extends State<MyFlickList> {
  List<Flicks> moviesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFlicks().then((value) {
      value == null
          ? setState(() {
              moviesList = [];
            })
          : setState(() {
              moviesList = value;
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: changeThemeBloc,
        builder: (BuildContext context, ChangeThemeState state) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Flicks on Your FlickList',
                        style: widget.themeData.textTheme.headline),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 550,
                child: moviesList == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : moviesList.isEmpty
                        ? Center(
                            child: Text(
                              "You don't have any Flicks Added In you FlickList",
                              style: state.themeData.textTheme.caption,
                            ),
                          )
                        : Swiper(
                            loop: false,
                            autoplayDisableOnInteraction: true,
                            autoplay: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserFlickDetail(
                                                addedOn:
                                                    moviesList[index].addedOn,
                                                movieId:
                                                    moviesList[index].movieId,
                                                themeData: widget.themeData,
                                                heroId:
                                                    '${moviesList[index].id}flicklist')));
                                  },
                                  onLongPress: () {
                                    Widget markAsNotCompletedButton =
                                        FlatButton(
                                      child: Text("Not Completed"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        CommonHelper.showProgressBar(
                                            context, 'Updating your FlickList');
                                        setState(() {
                                          moviesList[index].isWatched = false;
                                        });
                                        updateFlickList(
                                                moviesList[index].id, false)
                                            .then((value) {
                                          Navigator.pop(context);
                                          value.startsWith('Movie')
                                              ? widget.scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                  content:
                                                      Text('FlickList Updated'),
                                                  duration:
                                                      Duration(seconds: 3),
                                                ))
                                              : widget.scaffoldKey.currentState
                                                  .showSnackBar(SnackBar(
                                                  content: Text(value),
                                                  duration:
                                                      Duration(seconds: 3),
                                                ));
                                        });
                                      },
                                    );
                                    Widget cancelButton = FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget deleteButton = FlatButton(
                                      child: Text("Delete"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        CommonHelper.showProgressBar(
                                            context, 'Updating your FlickList');
                                        deleteFlickList(moviesList[index].id)
                                            .then((value) {
                                          Navigator.pop(context);
                                          if (value.startsWith('Data')) {
                                            widget.scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  '${moviesList[index].movieName} removed from your FlickList'),
                                              duration: Duration(seconds: 3),
                                            ));
                                            setState(() {
                                              moviesList.removeWhere((item) =>
                                                  item.id ==
                                                  moviesList[index].id);
                                            });
                                          } else {
                                            widget.scaffoldKey.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text(value),
                                              duration: Duration(seconds: 3),
                                            ));
                                          }
                                        });
                                      },
                                    );

                                    AlertDialog optionsDialog = new AlertDialog(
                                      title: Text('Options'),
                                      content: Text(
                                          'Please choose your options to perform Actions. \nYou can Delete your Flicks or Mark them as Not Completed from here.'),
                                      actions: <Widget>[
                                        markAsNotCompletedButton,
                                        cancelButton,
                                        deleteButton
                                      ],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return optionsDialog;
                                      },
                                    );
                                  },
                                  child: Hero(
                                    tag: '${moviesList[index].id}flicklist',
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          FadeInImage(
                                            image: NetworkImage(
                                                TMDB_BASE_IMAGE_URL +
                                                    'w500/' +
                                                    moviesList[index]
                                                        .posterPath),
                                            fit: BoxFit.cover,
                                            height: 400,
                                            placeholder: AssetImage(
                                                'assets/images/loading.gif'),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  moviesList[index].isWatched
                                                      ? Text('Completed',
                                                          style: state
                                                              .themeData
                                                              .textTheme
                                                              .headline)
                                                      : Text(
                                                          'Not Completed',
                                                          style: state
                                                              .themeData
                                                              .textTheme
                                                              .headline,
                                                        ),
                                                  moviesList[index].isWatched
                                                      ? Container()
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: ButtonTheme(
                                                            minWidth: 150,
                                                            child: RaisedButton(
                                                                color: state
                                                                    .themeData
                                                                    .bottomAppBarColor,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                    side: BorderSide(
                                                                        width:
                                                                            2,
                                                                        color: state
                                                                            .themeData
                                                                            .accentColor)),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                onPressed: () {
                                                                  CommonHelper
                                                                      .showProgressBar(
                                                                          context,
                                                                          'Updating your FlickList');
                                                                  setState(() {
                                                                    moviesList[
                                                                            index]
                                                                        .isWatched = true;
                                                                  });
                                                                  updateFlickList(
                                                                          moviesList[index]
                                                                              .id,
                                                                          true)
                                                                      .then(
                                                                          (value) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    value.startsWith(
                                                                            'Movie')
                                                                        ? widget
                                                                            .scaffoldKey
                                                                            .currentState
                                                                            .showSnackBar(
                                                                                SnackBar(
                                                                            content:
                                                                                Text('FlickList Updated'),
                                                                            duration:
                                                                                Duration(seconds: 3),
                                                                          ))
                                                                        : widget
                                                                            .scaffoldKey
                                                                            .currentState
                                                                            .showSnackBar(SnackBar(
                                                                            content:
                                                                                Text(value),
                                                                            duration:
                                                                                Duration(seconds: 3),
                                                                          ));
                                                                  });
                                                                },
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .done,
                                                                      size: 25,
                                                                      color: state
                                                                          .themeData
                                                                          .accentColor,
                                                                    ),
                                                                    Text(
                                                                      'Watched',
                                                                      style: state
                                                                          .themeData
                                                                          .textTheme
                                                                          .caption,
                                                                    )
                                                                  ],
                                                                )),
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: moviesList.length,
                            viewportFraction: 0.7,
                            scale: 0.9,
                          ),
              ),
            ],
          );
        });
  }
}
