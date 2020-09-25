import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/style/theme/strings.dart';
import 'package:flutter_hoo/ui/login/login_page.dart';
import 'package:flutter_hoo/widget/my_button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.25,
            child: Image.asset(
              "assets/images/welcome_bg.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Spacer(flex: 1),
          Text(
            Strings.welcome_info_1,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            Strings.welcome_info_2,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            Strings.welcome_info_3,
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 52, 20, 0),
            child: HooButton(
                true,
                Strings.welcome_button_login,
                () => Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => LoginPage()))),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: HooButton(
                true,
                Strings.welcome_button_register,
                () => Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => LoginPage()))),
          ),
          Spacer(flex: 1),
        ],
        //
      ),
    ));
  }
}
