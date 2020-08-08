import 'package:Test_Flutter_Developer_Sneakershoot/blocs/home_bloc.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/models/popular_movies.dart';
import 'package:Test_Flutter_Developer_Sneakershoot/utils/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class DetailPage extends StatelessWidget {
  // TextEditingController titleEditingController = TextEditingController(text: "");
  final Results data;
  final HomeBloc _homeBloc;
  DetailPage(this.data,this._homeBloc);
  String newTitle = "";
  @override
  Widget build(BuildContext context) {
    newTitle = data.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Movies"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: ()=>showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text("Edit Title"),
                content: TextFormField(
                  // controller: titleEditingController,
                  decoration: InputDecoration(
                    hintText: "Title"
                  ),
                  initialValue: data.title,
                  onChanged: (value) => newTitle = value,
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: ()=>Navigator.of(_).pop(),
                    child: Text("Cancel")
                  ),
                  FlatButton(
                    onPressed: ()=>_homeBloc.changeTitleState(_,data, newTitle),
                    child: Text("Save")
                  )
                ],
              ),
            )
          )
        ],
      ),
      body: ListView(
        controller: ScrollController(keepScrollOffset: false),
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: "${Constant.imageBaseUrl}/${data.backdropPath}",
              placeholder: (context, url) => Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator()
              ),
            ),
          ),
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
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
                          SizedBox(height: 5,),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Overview",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text(data.overview),
                    ],
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}