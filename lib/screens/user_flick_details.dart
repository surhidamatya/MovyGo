import 'package:flicklist/api/endpoints.dart';
import 'package:flicklist/constants/api_constants.dart';
import 'package:flicklist/models/flick_details.dart';
import 'package:flicklist/models/function.dart';
import 'package:flicklist/models/genres.dart';
import 'package:flicklist/models/movie.dart';
import 'package:flicklist/models/movie_credits.dart';
import 'package:flicklist/screens/widgets.dart';
import 'package:flicklist/utils/common_helper.dart';
import 'package:flicklist/utils/prefs.dart';
import 'package:flutter/material.dart';

class UserFlickDetail extends StatefulWidget {
  final ThemeData themeData;
  final String heroId, addedOn;
  final int movieId;

  UserFlickDetail({this.themeData, this.heroId, this.movieId, this.addedOn});

  @override
  _UserFlickDetailState createState() => _UserFlickDetailState();
}

class _UserFlickDetailState extends State<UserFlickDetail> {
  FlickDetails flickDetails;
  List addedDate = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFlickDetails(widget.movieId).then((value) {
      setState(() {
        flickDetails = value;
        addedDate = widget.addedOn.split('T');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: flickDetails == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          flickDetails.backdropPath == null
                              ? Image.asset(
                                  'assets/images/na.jpg',
                                  fit: BoxFit.cover,
                                )
                              : FadeInImage(
                                  width: double.infinity,
                                  height: double.infinity,
                                  image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                      'original/' +
                                      flickDetails.backdropPath),
                                  fit: BoxFit.cover,
                                  placeholder:
                                      AssetImage('assets/images/loading.gif'),
                                ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                gradient: LinearGradient(
                                    begin: FractionalOffset.bottomCenter,
                                    end: FractionalOffset.topCenter,
                                    colors: [
                                      widget.themeData.accentColor,
                                      widget.themeData.accentColor
                                          .withOpacity(0.3),
                                      widget.themeData.accentColor
                                          .withOpacity(0.2),
                                      widget.themeData.accentColor
                                          .withOpacity(0.1),
                                    ],
                                    stops: [
                                      0.0,
                                      0.25,
                                      0.5,
                                      0.75
                                    ])),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: widget.themeData.accentColor,
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: widget.themeData.accentColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 230, 16, 16),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  color: widget.themeData.primaryColor,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 120.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                flickDetails.title,
                                                style: widget.themeData
                                                    .textTheme.headline,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      flickDetails.rating
                                                          .toString(),
                                                      style: widget.themeData
                                                          .textTheme.body2,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.green,
                                                    ),
                                                    SizedBox(
                                                      width: 80,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                  width: double.infinity,
                                                  height: 50,
                                                  child: Center(
                                                    child: flickDetails
                                                                .genresList ==
                                                            null
                                                        ? CircularProgressIndicator()
                                                        : ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                BouncingScrollPhysics(),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                flickDetails
                                                                    .genresList
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                                child:
                                                                    Container(
                                                                  child: Chip(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                          width:
                                                                              1,
                                                                          style: BorderStyle
                                                                              .solid,
                                                                          color: widget
                                                                              .themeData
                                                                              .accentColor),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                    ),
                                                                    label: Text(
                                                                      flickDetails
                                                                          .genresList[
                                                                              index]
                                                                          .name,
                                                                      style: widget
                                                                          .themeData
                                                                          .textTheme
                                                                          .body2,
                                                                    ),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                  )),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'Overview',
                                                      style: widget.themeData
                                                          .textTheme.body2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  flickDetails.overview,
                                                  style: widget.themeData
                                                      .textTheme.caption,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            bottom: 4.0),
                                                    child: Text(
                                                      'Release date : ${flickDetails.releaseDate}',
                                                      style: widget.themeData
                                                          .textTheme.body2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            bottom: 4.0),
                                                    child: Text(
                                                      'Flick Added On : ${addedDate[0]}',
                                                      style: widget.themeData
                                                          .textTheme.body2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ScrollingArtists(
                                                api: Endpoints.getCreditsUrl(
                                                    flickDetails.id),
                                                title: 'Cast',
                                                tapButtonText:
                                                    'See full cast & crew',
                                                themeData: widget.themeData,
                                                onTap: (Cast cast) {
                                                  modalBottomSheetMenu(cast);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 40,
                              child: Hero(
                                tag: widget.heroId,
                                child: SizedBox(
                                  width: 100,
                                  height: 160,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: flickDetails.posterPath == null
                                        ? Image.asset(
                                            'assets/images/na.jpg',
                                            fit: BoxFit.cover,
                                          )
                                        : FadeInImage(
                                            image: NetworkImage(
                                                TMDB_BASE_IMAGE_URL +
                                                    'w500/' +
                                                    flickDetails.posterPath),
                                            fit: BoxFit.cover,
                                            placeholder: AssetImage(
                                                'assets/images/loading.gif'),
                                          ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
    );
  }

  void modalBottomSheetMenu(Cast cast) {
    // double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            // height: height / 2,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                      padding: const EdgeInsets.only(top: 54),
                      decoration: BoxDecoration(
                          color: widget.themeData.primaryColor,
                          borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(16.0),
                              topRight: const Radius.circular(16.0))),
                      child: Center(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '${cast.name}',
                                    style: widget.themeData.textTheme.body1,
                                  ),
                                  Text(
                                    'as',
                                    style: widget.themeData.textTheme.body1,
                                  ),
                                  Text(
                                    '${cast.character}',
                                    style: widget.themeData.textTheme.body1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.themeData.primaryColor,
                            border: Border.all(
                                color: widget.themeData.accentColor, width: 3),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: cast.profilePath == null
                                    ? AssetImage('assets/images/na.jpg')
                                    : NetworkImage(TMDB_BASE_IMAGE_URL +
                                        'w500/' +
                                        cast.profilePath)),
                            shape: BoxShape.circle),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
