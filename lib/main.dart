import 'package:flutter/material.dart';
import 'package:movies/api/tmdb_fetch.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/movie_profile_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vilkrig movies',
      theme: ThemeData(
        fontFamily: 'NunitoSans',
      ),
      debugShowCheckedModeBanner: false,
      
      home: MyHomePage(title: 'trending', movies: fetchMovies()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title , this.movies}) : super(key: key);

  final String title;
  final Future<Movies> movies;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
    
      body: 
      FutureBuilder<Movies> (
            future:widget.movies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child:
                  //titleSection,
                  FeaturedMoviesList(movies: snapshot.data.movies),
                 
               );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              );
            },   
        ),
      
      
        
    );
  }
}

 class FeaturedMoviesList extends StatelessWidget{
   final List<Movie> movies;
   FeaturedMoviesList({Key key, this.movies}) : super(key: key);

   @override 
   Widget build(BuildContext context){
     return GridView.builder(
             gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2 , childAspectRatio: 0.668),
              itemCount: movies == null ? 0: movies.length , 
              itemBuilder: (BuildContext context, index){
               return new Container(
          
                      child: GestureDetector(
                        child: Container(   
                          child: Stack(    
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network('https://image.tmdb.org/t/p/w1280${movies[index].poster}',fit: BoxFit.contain,),
                                  
                            const DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(0.0, 1.0),
                                      end: Alignment(0.0, -0.4),
                                      colors: <Color>[Color(0xf0000000), Color(0x00000000)],
                                    ),
                                  ),
                            ),
                            Positioned(
                                  left: 20,
                                  bottom: 60,
                                    child: AutoSizeText(movies[index].title, style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),),
                                  ),
                                  Positioned(
                                    left:20,
                                    bottom: 40,
                                    child: Text('Action | 136 min', style: TextStyle(fontSize: 11, color: Colors.grey[300], fontWeight: FontWeight.bold),),
                                  ),
                                   Positioned(
                                    left:20,
                                    bottom: 20,
                                    child: Text('IMDb ${movies[index].vote}/10', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),),
                                
                                  ),
                            ],
                          ),
                        ),
                        onTap: (){
                                  Navigator.push(context,
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                      new MovieProfileScreen(movies[index].id)
                                  )
                                  );
                                }, 
                       )
                      
                  );  
              }
     );
   }
 }
