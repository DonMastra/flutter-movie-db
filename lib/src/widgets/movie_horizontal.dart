import 'package:flutter/material.dart';

import 'package:movies_app/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({
    @required this.movies,
    @required this.nextPage,
  });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.25,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cards(context), se utiliza con el PageView()
        itemCount: movies.length,
        itemBuilder: (context, i) {
          return _card(context, movies[i]);
        },
      ),
    );
  }

  // Se utiliza esta clase con el itemBuilder()
  Widget _card(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-poster';
    final card = Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        // Navega a otra ruta (detail) y envia el objeto (movie) como argument
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

  // Ya no se utliza esta clase, se usa con el 'children[]' de PageView()
  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 5.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
