import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HooButton  extends StatelessWidget {

  final bool isButtonEnable;
  final String text;
  final VoidCallback callback;

  HooButton(this.isButtonEnable,this.text,this.callback);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: RaisedButton(
        color: isButtonEnable
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
        textColor: Colors.white,
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }


}

