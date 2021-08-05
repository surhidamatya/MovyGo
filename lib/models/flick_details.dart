import 'package:flicklist/models/genres.dart';

class FlickDetails {
  String backdropPath, overview, posterPath, releaseDate, title;
  int id, runtime;
  double rating;
  List<Genres> genresList;

  FlickDetails(
      {this.backdropPath,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.id,
      this.runtime,
      this.rating,
      this.genresList});

  FlickDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    rating = json['vote_average'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    runtime = json['runtime'];
    if (json['genres'] != null) {
      genresList = new List<Genres>();
      json['genres'].forEach((v) {
        genresList.add(new Genres.fromJson(v));
      });
    }
  }
}
