import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/common/constant/baseConstant.dart';
import 'package:flutter_hoo/common/utils/theme_utils.dart';
import 'package:flutter_hoo/provider/theme_provider.dart';
import 'package:flutter_hoo/style/theme/strings.dart';
import 'package:flutter_hoo/ui/main/fav_shoe_page.dart';
import 'package:flutter_hoo/ui/main/me_page.dart';
import 'package:flutter_hoo/ui/main/shoe_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _controller;
  bool _isActive = false;
  bool _isShowDarkBtn = false;
  String _modelHint = "";

  void onSelect(int pos) {
    setState(() {
      _isShowDarkBtn = pos == 2;
      _currentIndex = pos;
      _controller.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isActive = context.isDark;
    _modelHint = _isShowDarkBtn ? (_isActive ? "黑夜" : "白天") : "";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hoo",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          SizedBox(
            height: 56,
            child: Center(
              child: Text(
                _modelHint,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: ThemeUtils.getTextMainWhiteColor(context),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (_isShowDarkBtn)
            Consumer<ThemeProvider>(builder: (ctx, provider, child) {
              return Switch(
                  value: _isActive,
                  activeColor: ThemeUtils.getTextMainWhiteColor(context),
                  inactiveThumbColor: ThemeUtils.getTextMainWhiteColor(context),
                  onChanged: (active) {
                    _onThemeModelSelect(active, provider);
                  });
            })
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Strings.main_bottom_home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: Strings.main_bottom_fav,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: Strings.main_bottom_me,
          ),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        onTap: (index) => onSelect(index),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
      body: Container(
        alignment: Alignment.center,
        child: PageView(
          children: [
            ShoePage(),
            FavShoePage(),
            MePage(),
          ],
          controller: _controller,
          onPageChanged: (index) => onSelect(index),
        ),
      ),
    );
  }

  void _onThemeModelSelect(bool isActive, ThemeProvider provider) {
    if (provider.getThemeMode() == ThemeMode.system) return;
    provider.setTheme(isActive ? ThemeMode.dark : ThemeMode.light);
    setState(() {
      _isActive = isActive;
      _modelHint = _isActive ? "黑夜" : "白天";
    });
  }
}
