import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/style/theme/strings.dart';

class HooTextField extends StatelessWidget{


  HooTextField(this.icon,this.hintText,this.changedCallback);

  final IconData icon;
  final String hintText;
  final ValueChanged<String> changedCallback;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).dividerColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).primaryColor)),
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText2,
      ),
      onChanged: changedCallback,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }


}