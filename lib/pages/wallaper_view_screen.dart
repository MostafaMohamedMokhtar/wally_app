import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class WallpaperViewScreen extends StatefulWidget {
  final String image ;
  WallpaperViewScreen({this.image}) ;

  @override
  _WallpaperViewScreenState createState() => _WallpaperViewScreenState();
}

class _WallpaperViewScreenState extends State<WallpaperViewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                child: Hero(
                  tag: widget.image,
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    placeholder: (context, url) => Image(image: AssetImage('assets/placeholder.png'),),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
