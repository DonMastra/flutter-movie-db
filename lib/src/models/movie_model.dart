/*
 * El modelo mapea cada valor del json obtenido de la api
 * con las propiedades de la clase qeu identifica
 * a cada instancia de Movie().
 * La clase Movies() tiene dos constructores, en el que
 * el segundo genera una lista dinámica de un objeto,
 * recorre esa lista y mapea (asigna cada propiedad del json
 * a cada una de las propiedades de la clase con
 * el constructor .fronJsonMap), agregando cada película
 * a la lista de tipo 'Movie' > 'items'
 * 
 * Esta clase 'Movie' se generó copiando toda la raw data del
 * json obtenido de la api pública y usando al extensión "Paste JSON as code"
 */

class Movies {
  List<Movie> items = [];

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }

    for (var item in jsonList) {
      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  String uniqueId; // custom property, not in api
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://image.shutterstock.com/image-vector/no-image-available-sign-absence-260nw-373244122.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg() {
    if (backdropPath == null) {
      return 'https://image.shutterstock.com/image-vector/no-image-available-sign-absence-260nw-373244122.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
