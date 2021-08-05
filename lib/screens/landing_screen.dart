import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flicklist/api/endpoints.dart';
import 'package:flicklist/bloc/change_theme_bloc.dart';
import 'package:flicklist/bloc/change_theme_state.dart';
import 'package:flicklist/models/function.dart';
import 'package:flicklist/models/genres.dart';
import 'package:flicklist/models/movie.dart';
import 'package:flicklist/screens/movie_detail.dart';
import 'package:flicklist/screens/search_view.dart';
import 'package:flicklist/screens/settings.dart';
import 'package:flicklist/screens/widgets.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Genres> _genres;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchGenres().then((value) {
      _genres = value.genres;
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
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: state.themeData.accentColor,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              centerTitle: true,
              title: Text(
                'FlickList',
                style: state.themeData.textTheme.headline,
              ),
              backgroundColor: state.themeData.primaryColor,
              actions: <Widget>[
                IconButton(
                  color: state.themeData.accentColor,
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    if (_genres != null) {
                      final Movie result = await showSearch(
                          context: context,
                          delegate: MovieSearch(
                              genres: _genres, themeData: state.themeData));
                      if (result != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetailPage(
                                      movie: result,
                                      themeData: state.themeData,
                                      genres: _genres,
                                      heroId: '${result.id}search',
                                    )));
                      }
                    }
                  },
                )
              ],
            ),
            drawer: Drawer(
              child: SettingsPage(scaffoldKey: _scaffoldKey,),
            ),
            body: Container(
              color: state.themeData.primaryColor,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  DiscoverMovies(
                    themeData: state.themeData,
                    genres: _genres,
                  ),
                  ScrollingMovies(
                    themeData: state.themeData,
                    genres: _genres,
                    title: 'Top Rated Movies',
                    api: Endpoints.topRatedUrl(1),
                  ),
                  ScrollingMovies(
                    themeData: state.themeData,
                    genres: _genres,
                    title: 'Now Playing',
                    api: Endpoints.nowPlayingMoviesUrl(1),
                  ),
                  ScrollingMovies(
                    themeData: state.themeData,
                    genres: _genres,
                    title: 'Popular Movies',
                    api: Endpoints.popularMoviesUrl(1),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
