import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/style/theme/strings.dart';
import 'package:flutter_hoo/ui/main/fav_shoe_page.dart';
import 'package:flutter_hoo/ui/main/page_item.dart';
import 'package:flutter_hoo/ui/main/shoe_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _controller;

  void onSelect(int pos){
    setState(() {
      _currentIndex = pos;
      _controller.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    });
  }

  @override
  void initState() {
    _controller =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hoo",
          style: Theme.of(context).textTheme.headline5.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
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
            PageItem(Strings.main_bottom_me,Colors.green)
          ],
          controller: _controller,
          onPageChanged: (index) => onSelect(index),
        ),
      ),
    );
  }
}
