import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/api/tmdb_fetch.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MovieProfileScreen extends StatelessWidget {
  final id;
  
  MovieProfileScreen (this.id);
  @override
  Widget build(BuildContext context) =>
    new Material(
      color: Colors.black,
      child:
      FutureBuilder<MovieProfile> (
            future:fetchMovieProfile(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child:
                  new CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.black,
          pinned: true,
          expandedHeight: 300.0,
          flexibleSpace: FlexibleSpaceBar(
           background: Stack(
             fit: StackFit.expand,
             children: <Widget>[
               
                  
                Image.network('https://image.tmdb.org/t/p/w1280${snapshot.data.backdrop}', fit: BoxFit.cover),
                
                
               const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.0, 1.0),
                          end: Alignment(0.0, -0.2),
                          colors: <Color>[Color(0xf0000000), Color(0x00000000)],
                        ),
                      ),
                ),
               Positioned(
                  bottom: 0,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.play_arrow),
                    color: Colors.white,
                    iconSize: 55,
                    onPressed:  () {
                      FlutterYoutube.playYoutubeVideoById(
                      apiKey: "AIzaSyCB8NCnkSvokq9negwsvPJyj_wZss9uCI4",
                      videoId: "${snapshot.data.videos}",
                      autoPlay: true, //default falase
                      fullScreen: true,
                      );//default false
                    },

                  ) ,
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,0,35,5),
                
              child: 
              Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                            
                  Text('${snapshot.data.title}', maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontSize: 20 , fontWeight: FontWeight.bold),),
                  
               ],),
              )
               
                   
                
               
             ],
           )
           
        ),
    ),
      SliverToBoxAdapter(
        child: Padding(
                    padding: EdgeInsets.fromLTRB( 20,20,35,5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                         Text('IMDb  ${snapshot.data.vote} / 10', style: TextStyle(color: Colors.amber, fontSize: 14 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                         Text('${snapshot.data.runtime} min', style: TextStyle(color: Colors.amber, fontSize: 14 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

                      ],
                    )
                    
                    ),
      ),
      SliverToBoxAdapter(
        child:Padding(
          padding: EdgeInsets.fromLTRB( 20,20,0,10),
          child: Text('Overview', maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontSize: 16 , fontWeight: FontWeight.bold),),

        ) ,
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(snapshot.data.plot, style: TextStyle(fontSize: 14, color: Colors.white, height: 1.05),),
        ),
        ),
      SliverToBoxAdapter(
        child:Padding(
          padding: EdgeInsets.fromLTRB( 20,30,0,10),
          child: Text('Production Companies', maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontSize: 16 , fontWeight: FontWeight.bold),),

        ) ,
      ),
      SliverToBoxAdapter(
        child:Padding(
          padding: EdgeInsets.fromLTRB( 20,15,0,10),
          child: 
          Row(
            children: <Widget>[
              Container(
            height: 20,
            child:           
              Image.network('https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.png'),
          ),
            ],
          )
          
        ) ,
      ),
      
      ],
      
    ),
                 
               );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child:CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                )
              );
            },   
        ),
    );
}