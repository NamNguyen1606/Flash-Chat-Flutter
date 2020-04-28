import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageProductView extends StatefulWidget {
  ImageProductView({
    this.onlineImage = '',
  });
  final String onlineImage;
  @override
  _ImageProductViewState createState() => _ImageProductViewState();
}

class _ImageProductViewState extends State<ImageProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: PhotoView(
                imageProvider: NetworkImage(widget.onlineImage),
              ),
            ),
            Positioned(
              child: IconButton(
                color: Colors.white,
                iconSize: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.arrow_back_ios, size: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
