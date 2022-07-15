import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallimp/views/image_view.dart';

import '../model/wallpaper_model.dart';

Widget BrandName(){
  return Row(mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
    Text('Wall', style: TextStyle(color: Colors.black),),
    Text('Imp', style: TextStyle(color: Colors.blueAccent),),
  ],);
}

Widget WallpapersList(List<WallpaperModel> wallpapers, context){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(crossAxisCount: 2,
    shrinkWrap: true,
    physics: ClampingScrollPhysics(),
    childAspectRatio: 0.6,
    mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
            ImageView(imgUrl: wallpaper.src.portrait)));
          },
          child: Hero(
            tag: wallpaper.src.portrait,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(imageUrl: wallpaper.src.portrait, fit: BoxFit.cover,
                  placeholder: (context, url)=>const Center(child: CircularProgressIndicator()))
              )

            ),
          ),
        ));
      }).toList(),
    ),
  );
}