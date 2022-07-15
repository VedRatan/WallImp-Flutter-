import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallimp/data/data.dart';
import 'package:wallimp/model/wallpaper_model.dart';
import 'package:wallimp/views/categories.dart';
import 'package:wallimp/views/image_view.dart';
import 'package:wallimp/views/search.dart';
import 'package:wallimp/widgets/widget.dart';
import '../model/categories_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    categories = getCategories();
    super.initState();
    getTrendingWallpapers();
  }

  getTrendingWallpapers() async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=60&page=1"),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                      searchQuery: searchController.text)));
                        },
                        child: const Icon(Icons.search))
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].categoriesName,
                      imgUrl: categories[index].imageUrl,
                    );
                  },
                ),
              ),
              WallpapersList(wallpapers, context)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  CategoriesTile({Key? key, required this.title, required this.imgUrl})
      : super(key: key);
  final String imgUrl, title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                Categorie(
                    categorieName: title.toLowerCase()
                )
            )
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 4.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
                  placeholder: (context, url)=>const Center(child: CircularProgressIndicator())
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                height: 50,
                width: 100,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }
}
