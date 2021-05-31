import 'package:flutter/material.dart';
import 'class/item.dart';

class ResultTile extends StatefulWidget{
  ResultTile(this._item);
  final Item _item;

  @override
  _ResultTileState createState() => _ResultTileState();
}

class _ResultTileState extends State<ResultTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget._item.restName, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black45),),
      trailing: Text('${widget._item.peopleNum}', style: TextStyle(fontSize: 16, color: Colors.black45),),
    );
  }
}

class TopResultTile extends StatefulWidget{
  TopResultTile(this._item);
  final Item _item;

  @override
  _TopResultTileState createState() => _TopResultTileState();
}

class _TopResultTileState extends State<TopResultTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      title: Text(widget._item.restName, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
      trailing: Text('${widget._item.peopleNum}', style: TextStyle(fontSize: 20, color: Colors.deepPurpleAccent),),
    );
  }
}

class ResultPage extends StatelessWidget{
  ResultPage(this._items);
  final List<Item> _items;

  @override
  Widget build(BuildContext context) {
    final appTitle = '먹VOTE';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle,
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
        ),
        body:SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Icon(Icons.check, size: 30, color: Colors.deepPurpleAccent,),
                SizedBox(height: 10,),
                Text('투표결과', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
                SizedBox(height: 30,),
                ResultBuilder(_items),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ResultBuilder extends StatelessWidget {
  ResultBuilder(this._items);
  final List<Item> _items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      // itemCount: items.length + 1,
      itemCount: _items.length,
      separatorBuilder: (BuildContext context, int index){
        return Container(
            height: 20,
            child: Divider(height: 5));},
      itemBuilder: (BuildContext context, int index) {
        return index > 2 ? ResultTile(_items[index]) : TopResultTile(_items[index]);
      },
    );
  }
}