import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled23/STATE%20MANAGEMENT/provider/movei%20provider.dart';
import 'package:untitled23/STATE%20MANAGEMENT/screen/wishlist%20page.dart';

void main(){
  runApp(ChangeNotifierProvider<MovieProvider>(
      create: (BuildContext context)=>MovieProvider(),
  child: MaterialApp(
    home: mainScreen(),
  ),));
}
class mainScreen extends StatelessWidget {
  const mainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var whishmovie=context.watch<MovieProvider>().movieWhishList;
    var movie=context.watch<MovieProvider>().movies;
    return Scaffold(
      appBar: AppBar(title: Text("Movies"),
      ),
      body: Column(
        children: [
     ElevatedButton.icon(onPressed: ()=> Navigator.of(context).push(
       MaterialPageRoute(builder: (context)=> WhishListScreen())),
         icon: const Icon(Icons.favorite_border),
         label: Text("Goto whishlist ${whishmovie.length}")),
          Expanded(
              child:ListView.builder(
                  itemCount: movie.length,
                  itemBuilder: (context,index){
                    final currentMovie =movie[index];
                    return Card(
                      child:ListTile(
                        title: Text(currentMovie.title),
                        subtitle: Text(currentMovie.time!),
                        trailing: IconButton(
                            icon:Icon(Icons.favorite),
                        color: whishmovie.contains(currentMovie)
                          ?Colors.red
                          :Colors.black26,
                          onPressed: () {
                              if(!whishmovie.contains(currentMovie)){
                                context
                                .read<MovieProvider>()
                                    .addWhishList(currentMovie);
                              }else{
                                context
                                .read<MovieProvider>()
                                    .removeFromWhishList(currentMovie);
                              }
                          },
                        ),
                      ),
                    );

              }) )
        ]
      ),
    );
  }
}
