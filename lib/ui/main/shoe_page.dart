import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hoo/db/database.dart';
import 'package:flutter_hoo/db/shoe.dart';
import 'package:flutter_hoo/ui/main/shoe/shoe_item.dart';
import 'package:flutter_hoo/widget/my_refresh_list.dart';
import 'package:flutter_hoo/widget/state_layout.dart';

class ShoePage extends StatefulWidget {
  @override
  _ShoePageState createState() => _ShoePageState();
}

class _ShoePageState extends State<ShoePage> {
  // 使用分页通过Id id是自增长的
  // 根据Id显示

  List<Shoe> _shoes = new List<Shoe>();
  int _page = 1;
  int _lastLoadSize = 20;
  StateType type = StateType.loading;

  @override
  void initState() {
    super.initState();

    _onRefresh();
  }

  @override
  Widget build(BuildContext context){
    return new Container(
      child: RefreshListView(
        onRefresh: _onRefresh,
        onLoadMore: _onLoadMore,
        hasMore: _lastLoadSize > 0,
        itemCount: _shoes.length,
        stateType: type,
        itemBuilder: (_,pos){
          Shoe shoe = _shoes[pos];
          return ShoeItem(shoe);
        },
      ),
    );
  }

  Future _onRefresh() async {
    _page = 1;
    DBProvider provider = DBProvider.getInstance();
    int startPos = (_page - 1) * 20;
    int endPos = startPos + 20;
    List<Shoe> shoes = await provider.queryShoeByPos(startPos,endPos);
    setState(() {
      _lastLoadSize = shoes.length;
      _shoes.addAll(shoes);
    });
  }

  Future _onLoadMore() async {
    _page++;
    DBProvider provider = DBProvider.getInstance();
    int startPos = (_page - 1) * 20;
    int endPos = startPos + 20;
    List<Shoe> shoes = await provider.queryShoeByPos(startPos,endPos);
    setState(() {
      _lastLoadSize = shoes.length;
      _shoes.addAll(shoes);
    });
  }


}
