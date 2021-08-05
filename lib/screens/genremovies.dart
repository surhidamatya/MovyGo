import 'package:flicklist/api/endpoints.dart';
import 'package:flicklist/models/genres.dart';
import 'package:flicklist/screens/widgets.dart';
import 'package:flutter/material.dart';

class GenreMovies extends StatelessWidget {
  final ThemeData themeData;
  final Genres genre;
  final List<Genres> genres;

  GenreMovies({this.themeData, this.genre, this.genres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.primaryColor,
        title: Text(
          genre.name,
          style: themeData.textTheme.headline,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeData.accentColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ParticularGenreMovies(
        themeData: themeData,
        api: Endpoints.getMoviesForGenre(genre.id, 1),
        genres: genres,
      ),
    );
  }
}
