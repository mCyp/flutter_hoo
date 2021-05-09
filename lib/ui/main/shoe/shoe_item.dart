import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/db/shoe.dart';
import 'package:flutter_hoo/ui/detail/shoe_detail_page.dart';
import 'package:flutter_hoo/widget/load_image.dart';

class ShoeItem extends StatelessWidget {
  ShoeItem(this._shoe);

  final Shoe _shoe;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Material(
        child: Ink(
          child: InkWell(
            onTap: () {
              print("shoeId: " + _shoe.id.toString());
              Navigator.of(context)
                  .push(PageRouteBuilder(pageBuilder: (ctx, start, end) {
                return new FadeTransition(
                  opacity: start,
                  child: ShoeDetailPage(_shoe),
                );
              }));
            },
            child: Hero(
              tag: _shoe.imageUrl,
              child: LoadImage(_shoe.imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
