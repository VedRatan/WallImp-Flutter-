import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io' show Platform;

import 'package:permission_handler/permission_handler.dart';
class ImageView extends StatefulWidget {
  final String imgUrl;

  const ImageView({Key? key, required this.imgUrl}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Hero(
          tag: widget.imgUrl,
          child: Container(
            height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imgUrl, fit: BoxFit.cover ,)
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  _save();
                },
                child: Stack(
                  children: <Widget>[

                    Container(
                      height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      width: MediaQuery.of(context).size.width/2,

                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xff1C1B1B).withOpacity(0.8),
                        )
                    ),

                    Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration:  BoxDecoration(
                      border: Border.all(color: Colors.white60, width: 1),
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                            colors: [
                              Color(0x36FFFFFF),
                              Color(0x0fFFFFFF)
                            ]
                        )
                    ),
                    child: Column(children: const <Widget>[
                      Text('Download Image',style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70
                      ),),


                      Text('Image will be saved in gallery', style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70
                      ),)
                    ],),
                  ),
                ]),
              ),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Text('Cancel' ,style: TextStyle(color: Colors.white),)
              ) ,
              const SizedBox(height: 50,)
            ],
          ),
        )
      ],),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
    if(isIOS)
      {
        await Permission.photos.request();
      }
  else {
      /* PermissionStatus permission = */await Permission.storage.request();
    }
  }
}
