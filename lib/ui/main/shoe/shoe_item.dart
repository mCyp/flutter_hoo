import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/db/shoe.dart';
import 'package:flutter_hoo/widget/load_image.dart';

class ShoeItem extends StatelessWidget {

  ShoeItem(this._shoe);

  Shoe _shoe;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Material(
        child: Ink(
          child: InkWell(
              onTap: (){
                // TODO 跳转到具体页面
              },
              child: LoadImage(
                  _shoe.imageUrl
              )
          ),
        ),
      ),
    );
  }
}
