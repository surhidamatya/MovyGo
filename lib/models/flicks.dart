class FlickList {
  String status;
  int postCount;
  List<Flicks> flicks;

  FlickList({this.status, this.postCount, this.flicks});

  FlickList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    postCount = json['postCount'];
    if (json['data'] != null) {
      flicks = new List<Flicks>();
      json['data'].forEach((v) {
        flicks.add(new Flicks.fromJson(v));
      });
    }
  }
}

class Flicks {
  bool isWatched;
  String addedOn;
  String id;
  String movieName;
  int movieId;
  String posterPath;
  String rating;

  Flicks(
      {this.isWatched,
      this.addedOn,
      this.id,
      this.movieName,
      this.movieId,
      this.posterPath,
      this.rating});

  Flicks.fromJson(Map<String, dynamic> json) {
    isWatched = json['isWatched'];
    id = json['_id'];
    addedOn = json['addedOn'];
    rating = json['rating'].toString();
    movieName = json['movieName'];
    movieId = json['movieId'];
    posterPath = json['posterPath'];
  }
}
