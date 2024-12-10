 import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:untitled23/STATE%20MANAGEMENT/model/movie.dart';

final List<Movie>movieList = List.generate(

     100, (index)=>Movie(title: 'Movie $index',
time: '${Random().nextInt(100)+60}minutes')
 );

class MovieProvider extends ChangeNotifier {

  final List<Movie> _movie = movieList;


  List<Movie>get movies => _movie;

  final List<Movie>_wishListMovie =[];

  List<Movie>get movieWhishList => _wishListMovie;


  void addWhishList(Movie movieFromMainPage){
    _wishListMovie.add(movieFromMainPage);
    notifyListeners();
  }
  void removeFromWhishList(Movie removedMovie){
    _wishListMovie.remove(removedMovie);
    notifyListeners();
  }
}

