import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/data.dart';
import '../model/wallpaper_model.dart';
import '../widgets/widget.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class Search extends StatefulWidget {
  final String searchQuery;

  Search({Key? key,required this.searchQuery}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}


class _SearchState extends State<Search> {

  TextEditingController searchController = new TextEditingController();
  List<WallpaperModel> wallpapers = [];

  @override
  void initState() {
    // TODO: implement

    super.initState();
    searchController.text = widget.searchQuery;
    developer.log(widget.searchQuery);
    getSearchWallpapers(widget.searchQuery);

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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        getSearchWallpapers(searchController.text);
                      },
                      child: const Icon(Icons.search))
                ],
              ),
            ),
            WallpapersList(wallpapers, context)
          ],),
        ),
      ),
    );
  }
}

