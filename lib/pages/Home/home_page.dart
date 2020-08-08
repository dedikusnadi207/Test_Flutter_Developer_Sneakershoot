import 'package:Test_Flutter_Developer_Sneakershoot/blocs/home_bloc.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/models/popular_movies.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/pages/Home/detail_page.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;
  @override
  void initState() {
    super.initState();
    init();
  }
  init(){
    _homeBloc = HomeBloc();
    _homeBloc.getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
      ),
      body: StreamBuilder(
        stream: _homeBloc.popularMoviesController.stream,
        builder: (_,AsyncSnapshot<PopularMovies> snapshot){
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
          if(snapshot.data.results.length == 0) return Container(child: Center(child: Text("Data Not Found")),);
          return ListView.builder(
            itemCount: snapshot.data.results.length,
            itemBuilder: (_,index){
              var data = snapshot.data.results[index];
              return Container(
                margin: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>DetailPage(data,_homeBloc))),
                  child: Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Hero(
                            tag: "Poster${data.id}",
                            child: CachedNetworkImage(
                              imageUrl: "${Constant.imageBaseUrl}/${data.posterPath}",
                              placeholder: (context, url) => Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator()
                              ),
                            )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                data.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.calendar_today),
                                  SizedBox(width: 5,),
                                  Text(data.releaseDate)
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.star),
                                  SizedBox(width: 5,),
                                  Text(data.voteAverage.toString())
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  Text("Vote : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(width: 5,),
                                  Text(data.popularity.toString())
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: <Widget>[
                                  Text("Popularity : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(width: 5,),
                                  Text(data.voteCount.toString())
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        },
      ),
    );
  }
}