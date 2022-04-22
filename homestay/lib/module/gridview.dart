import 'package:flutter/material.dart';

class gridLayout extends StatefulWidget {
 
  late List<String> photo_collection;
  gridLayout(photo_collection) {
    this.photo_collection = photo_collection;
  }
  @override
  State<gridLayout> createState() => _gridLayoutState();
}

late String imageLink;

class _gridLayoutState extends State<gridLayout> {
  void showAlertDialog(BuildContext context, imageLink) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: InteractiveViewer(
            // clipBehavior: Clip.none,
            child: Image(
              image: NetworkImage(imageLink),
              fit: BoxFit.fill,
            ),
          ),
          insetPadding: EdgeInsets.all(5),
          contentPadding: EdgeInsets.all(5),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.photo_collection.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            childAspectRatio:
                1.25, //size of container/widget attached to gridview//
            mainAxisSpacing: 5),
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              showAlertDialog(context, widget.photo_collection[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.photo_collection[index]),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        });
  }
}
