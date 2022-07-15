import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../model/wallpaper_model.dart';
import '../widgets/widget.dart';
class Categorie extends StatefulWidget {
  final String categorieName;
  const Categorie({Key? key, required this.categorieName}) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  @override
  @override
  List<WallpaperModel> wallpapers =  [];
  void initState() {
    // TODO: implement

    super.initState();

    getSearchWallpapers(widget.categorieName);

  }

  getSearchWallpapers(query) async {
    var response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=60&page=1"),
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel;
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: BrandName(),
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: const Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
            ),
            WallpapersList(wallpapers, context)
          ],),
        ),
      ),
    );
  }
}
