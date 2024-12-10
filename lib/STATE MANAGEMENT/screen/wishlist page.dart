import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled23/STATE%20MANAGEMENT/provider/movei%20provider.dart';

class WhishListScreen extends StatelessWidget {
  const WhishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var whishmovie=context.watch<MovieProvider>().movieWhishList;
    return Scaffold(
      appBar: AppBar(title: Text("WhishList ${whishmovie.length}"),
      ),
      body: ListView.builder(
        itemCount: whishmovie.length,
          itemBuilder: (context, index){
        final whishMovie = whishmovie[index];
        return Card(
          child: ListTile(
            title: Text(whishMovie.title),
            subtitle: Text(whishMovie.time!),
            trailing: TextButton(
              onPressed: (){
               context.read<MovieProvider>().removeFromWhishList(whishMovie);
              }, child: Text("Remove"),
            ),
          ),
        );
      }),
    );
  }
}
