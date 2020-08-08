import 'package:Test_Flutter_Developer_Sneakershoot/models/popular_movies.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/utils/api_client.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/utils/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:toast/toast.dart';

class HomeBloc extends Object implements BlocBase {
  BehaviorSubject<PopularMovies> popularMoviesController;
  @override
  void dispose() {
    popularMoviesController.close();
  }
  HomeBloc(){
    popularMoviesController = BehaviorSubject<PopularMovies>();
  }
  getData()async{
    PopularMovies popularMovies = await ApiClient.popularMoviesList();
    popularMoviesController.sink.add(popularMovies);
  }
  changeTitleState(BuildContext ctx, Results results, String title)async{
    PopularMovies currentPopularMovies = popularMoviesController.value;
    int index = currentPopularMovies.results.indexWhere((element) => element.id == results.id);
    currentPopularMovies.results[index].title = title;
    popularMoviesController.sink.add(currentPopularMovies);
    Toast.show("Data successfully saved", ctx,duration: Toast.LENGTH_LONG);
    Navigator.of(ctx).pop();
  }
}