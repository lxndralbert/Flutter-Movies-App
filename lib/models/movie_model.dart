class Movie {
  final String title;
  final String plot;
  final String poster;
  final String year;
  final String backdrop;
  final int id;
  final double vote;
  
  Movie({this.title, this.plot , this.poster, this.id, this.year,this.backdrop, this.vote, });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      vote: json['vote_average'].toDouble(),
      title: json['title'],
      plot: json['overview'],
      poster: json['poster_path'],
      year: json['release_date'],
      backdrop: json['backdrop_path'],
      
    );
  }
}

class MovieProfile {
  final String title;
  final String plot;
  final String poster;
  final String year;
  final String backdrop;
  final int id;
  final int runtime;
  final double vote;
  final String videos;
  MovieProfile({this.title, this.plot , this.poster, this.id, this.year,this.backdrop, this.vote, this.videos, this.runtime});

  factory MovieProfile.fromJson(Map<String, dynamic> json) {
   

    return MovieProfile(
      id: json['id'],
      vote: json['vote_average'].toDouble(),
      title: json['title'],
      plot: json['overview'],
      poster: json['poster_path'],
      year: json['release_date'],
      backdrop: json['backdrop_path'],
      runtime: json['runtime'],
      videos: json['videos']['results'][0]['key'],
    );
  }
}

class Movies {
  final List<Movie> movies;
  
  Movies({this.movies});

  factory Movies.fromJson(Map<String, dynamic> json){
    var list = json['results'] as List;
      
    List<Movie> movieList = list.map((i) => Movie.fromJson(i)).toList();

    return Movies(
      movies: movieList,   
    );
    
  }
  
}