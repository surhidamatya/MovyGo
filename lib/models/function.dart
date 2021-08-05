import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flicklist/api/endpoints.dart';
import 'package:flicklist/constants/api_constants.dart';
import 'package:flicklist/models/flick_details.dart';
import 'package:flicklist/models/flicks.dart';
import 'package:flicklist/models/genres.dart';
import 'package:flicklist/models/movie.dart';
import 'package:flicklist/models/movie_credits.dart';
import 'package:flicklist/utils/prefs.dart';
import 'package:http/http.dart' as http;

Future<List<Movie>> fetchMovies(String api) async {
  MovieList movieList;
  var res = await http.get(api);
  var decodeRes = jsonDecode(res.body);
  movieList = MovieList.fromJson(decodeRes);
  return movieList.movies;
}

Future<MovieCredits> fetchCredits(String api) async {
  MovieCredits credits;
  var res = await http.get(api);
  var decodeRes = jsonDecode(res.body);
  credits = MovieCredits.fromJson(decodeRes);
  return credits;
}

Future<GenresList> fetchGenres() async {
  GenresList genresList;
  var res = await http.get(Endpoints.genresUrl());
  var decodeRes = jsonDecode(res.body);
  genresList = GenresList.fromJson(decodeRes);
  return genresList;
}

Future<String> apiPostRequest(String url, Map jsonMap,
    [String apiToken]) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('Accept', 'application/json');
  request.headers.set('Content-type', 'application/json');
  if (apiToken != null) {
    request.headers.set('Authorization', 'Bearer $apiToken');
  }
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}

Future<String> apiPatchRequest(String url, Map jsonMap,
    [String apiToken]) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.patchUrl(Uri.parse(url));
  request.headers.set('Accept', 'application/json');
  request.headers.set('Content-type', 'application/json');
  if (apiToken != null) {
    request.headers.set('Authorization', 'Bearer $apiToken');
  }
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}

Future<String> makeLoginRequest(String email, String password) async {
  String route = "$FLICKLIST_BASE_URL/auth/login";
  Map loginMap = {'email': email.trim(), 'password': password.trim()};
  Map<String, dynamic> response =
      json.decode(await apiPostRequest(route, loginMap));
  if (response['status'] == 'Success') {
    Map<String, dynamic> userInfo = response['user'];
    Prefs.setUserEmail(userInfo['email']);
    Prefs.setUserName(userInfo['username']);
    Prefs.setUserId(userInfo['_id']);
    Prefs.setApiToken(response['token']);
  } else {
    print(response['message']);
    Prefs.clear();
    return response['message'];
  }
  return response['token'];
}

Future<String> makeSignupRequest(String username, String email, String password,
    String passwordConfirm) async {
  String welcomeMessage = '';
  String route = "$FLICKLIST_BASE_URL/auth/signup";
  Map signupMap = {
    "username": username.trim(),
    "email": email.trim(),
    "password": password.trim(),
    "passwordConfirm": password.trim()
  };
  Map<String, dynamic> response =
      json.decode(await apiPostRequest(route, signupMap));
  if (response['status'] == 'Success') {
    Map<String, dynamic> userInfo = response['user'];
    welcomeMessage =
        "Registered Successfully. Welcome ${userInfo['username']}. Now LogIn to access your FlickList";
  } else {
    print(response['message']);
    return response['message'];
  }
  return welcomeMessage;
}

Future<String> makeForgotPasswordRequest(String email) async {
  String route = "$FLICKLIST_BASE_URL/auth/forgotPassword";
  Map forgotPasswordRoute = {"email": email.trim()};
  Map<String, dynamic> response =
      json.decode(await apiPostRequest(route, forgotPasswordRoute));
  return response['message'];
}

Future<String> makeResetPasswordRequest(
    String resetToken, String password, String passwordConfirm) async {
  String route = "$FLICKLIST_BASE_URL/auth/resetPassword/$resetToken";
  Map resetPasswordMap = {
    "password": password.trim(),
    "passwordConfirm": passwordConfirm.trim()
  };
  Map<String, dynamic> response =
      json.decode(await apiPatchRequest(route, resetPasswordMap));
  if (response['status'] == 'Success') {
    Map<String, dynamic> userInfo = response['user'];
    return 'Success,${userInfo['email']}';
  }
  print(response['message']);
  return response['message'];
}

Future<List<Flicks>> fetchFlicks() async {
  String route = "$FLICKLIST_BASE_URL/flicks";
  var res = Prefs.apiToken.then((value) async {
    FlickList flickList;
    var response =
        await http.get(route, headers: {'Authorization': 'Bearer $value'});
    var decodeResponse = jsonDecode(response.body);
    flickList = FlickList.fromJson(decodeResponse);
    return flickList.flicks;
  });
  return res;
}

Future<dynamic> getFlickAddedStatus(String movieId) async {
  var res = Prefs.apiToken.then((apiTokenValue) async {
    var reply = Prefs.userId.then((userIdValue) async {
      String route = '$FLICKLIST_BASE_URL/flicks/flick/$movieId/$userIdValue';
      http.Response response = await http
          .get(route, headers: {'Authorization': 'Bearer $apiTokenValue'});
      Map<String, dynamic> item = json.decode(response.body);
      if (response.statusCode == 200) {
        return '${item['status']} on getting movie';
      }
      return item['message'];
    });
    return reply;
  });
  return res;
}

Future<dynamic> postFlick(String movieName, String movieId, String posterPath,
    String rating, String bearerUser) async {
  String route = '$FLICKLIST_BASE_URL/flicks';
  Map postFlicksMap = {
    "movieName": movieName.trim(),
    "movieId": movieId.trim(),
    "posterPath": posterPath.trim(),
    "rating": rating.trim(),
    "addedBy": bearerUser.trim()
  };
  var res = Prefs.apiToken.then((value) async {
    Map<String, dynamic> response =
        json.decode(await apiPostRequest(route, postFlicksMap, value));
    if (response['status'] == 'Success') {
      Map<String, dynamic> movieData = response['data'];
      return 'Succesfully added ${movieData['movieName']} to your FlickList';
    }
    return response['message'];
  });
  return res;
}

Future<String> updateFlickList(String movieId, bool isWatched) async {
  String route = '$FLICKLIST_BASE_URL/flicks/flick/$movieId';
  Map setFlicksAsWatchedMap = {"isWatched": isWatched};
  var res = Prefs.apiToken.then((value) async {
    Map<String, dynamic> response =
        json.decode(await apiPatchRequest(route, setFlicksAsWatchedMap, value));
    if (response['status'] == 'Success') {
      return isWatched ? 'Movie set as Completed' : 'Movie set as InComplete';
    }
    return "Couldn't Update FlickList. Try Again";
  });
  return res;
}

Future<dynamic> deleteFlickList(String movieId) async {
  String route = '$FLICKLIST_BASE_URL/flicks/flick/$movieId';
  var res = Prefs.apiToken.then((value) async {
    http.Response response =
        await http.delete(route, headers: {'Authorization': 'Bearer $value'});
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      return decodedResponse['data'];
    }
    return 'Flick deletion not completed. Try Again';
  });
  return res;
}

Future<FlickDetails> fetchFlickDetails(int movieId) async {
  String route = Endpoints.movieDetailsUrl(movieId);
  FlickDetails flickDetails;
  var response = await http.get(route);
  var decodedResponse = jsonDecode(response.body);
  flickDetails = FlickDetails.fromJson(decodedResponse);
  return flickDetails;
}

Future<dynamic> verifyToken() async {
  var res = Prefs.apiToken.then((value) async {
    String route = '$FLICKLIST_BASE_URL/auth/verifyToken';
    http.Response response =
        await http.get(route, headers: {'Authorization': 'Bearer $value'});
    Map<String, dynamic> decodedResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return decodedResponse['status'];
    }
    return decodedResponse['message'];
  });
  return res;
}

Future<dynamic> updatePassword(
    String currentPassword, String newPassword, String confirmPassword) async {
  String route = '$FLICKLIST_BASE_URL/auth/updatePassword';
  Map updatePasswordMap = {
    "passwordCurrent": currentPassword,
    "newPassword": newPassword,
    "passwordConfirm": confirmPassword
  };
  var res = Prefs.apiToken.then((value) async {
    Map<String, dynamic> decodedResponse =
        json.decode(await apiPatchRequest(route, updatePasswordMap, value));
    if (decodedResponse['status'] == 'Success') {
      Prefs.setApiToken(decodedResponse['token']);
      return 'Successfully Updated Password ';
    }
    return decodedResponse['message'];
  });
  return res;
}
