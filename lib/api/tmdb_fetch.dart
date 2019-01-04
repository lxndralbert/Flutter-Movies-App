import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/models/movie_model.dart';


Future<Movies> fetchMovies() async {
  final trendingResponse =
      await http.get('https://api.themoviedb.org/3/discover/movie?api_key=47041cfe17ba6a5a44d522a14e31bc58&language=en-US&include_adult=false&include_video=true&page=1');
  if (trendingResponse.statusCode == 200) {
    return Movies.fromJson(json.decode(trendingResponse.body));
  } else {
    throw Exception('Failed to load movie');
  }
}

Future<MovieProfile> fetchMovieProfile(int id) async {
  final profileResponse =
      await http.get('https://api.themoviedb.org/3/movie/${id}?api_key=47041cfe17ba6a5a44d522a14e31bc58&language=en-US&append_to_response=videos');
  if (profileResponse.statusCode == 200) {
    return MovieProfile.fromJson(json.decode(profileResponse.body));
  } else {
    throw Exception('Failed to load movie');
  }
}