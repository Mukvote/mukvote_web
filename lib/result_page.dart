import 'package:flutter/material.dart';
import 'class/item.dart';

class ResultTile extends StatefulWidget{
  ResultTile(this._restaurant, this.idx);
  final Item _restaurant;
  final int idx;

  @override
  _ResultTileState createState() => _ResultTileState();
}

class _ResultTileState extends State<ResultTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text((widget.idx + 1).toString(), style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black45),)),
      title: Text(widget._restaurant.restaurant.name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black45),),
      trailing: Text('${widget._restaurant.restaurant.place}', style: TextStyle(fontSize: 16, color: Colors.black45),),
    );
  }
}

class TopResultTile extends StatefulWidget{
  TopResultTile(this._item, this.idx);
  final Item _item;
  final int idx;
  String img = 'assets/1_dotori.png';

  void bedge(int n){
    switch(n) {
      case 0: {
        img = 'assets/1_dotori.png';
      }
      break;

      case 1: {
        img = 'assets/2_dotori.png';
      }
      break;

      case 2: {
        img = 'assets/3_dotori.png';
      }
      break;
    }
  }

  @override
  _TopResultTileState createState() => _TopResultTileState();
}

class _TopResultTileState extends State<TopResultTile> {
  @override
  Widget build(BuildContext context) {
    widget.bedge(widget.idx);

    return Container(
      // decoration: new BoxDecoration (
      //     color: Color(0XFF7C4DFF)
      // ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Image.asset(
            widget.img,
            width: 50,
            height: widget.idx == 0 ? 100 : 40 ,
        ),
        title: Text(widget._item.restaurant.name, style: TextStyle(fontSize: widget.idx == 0 ? 20 : 18,fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
        trailing: Text('${widget._item.restaurant.place}', style: TextStyle(fontSize: widget.idx == 0 ? 20 : 18, color: Colors.deepPurpleAccent),),
      ),
    );
  }
}

class ResultPage extends StatelessWidget{
  ResultPage(this._restaurant);
  final List<Item> _restaurant;

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
                SizedBox(height: 20,),
                Image.asset(
                    'assets/투표완료.png',
                  width: 180,
                ),
                SizedBox(height: 40,),
                ResultBuilder(_restaurant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ResultBuilder extends StatelessWidget {
  ResultBuilder(this._restaurant);
  final List<Item> _restaurant;

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     physics: ClampingScrollPhysics(),
    //     padding: const EdgeInsets.all(8),
    //     itemCount: _restaurant.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         height: 50,
    //         color: Color(0X1A7C4DFF),
    //         child: ResultTile(_restaurant[index])
    //       );
    //     }
    // );
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      // itemCount: items.length + 1,
      itemCount: _restaurant.length,
      separatorBuilder: (BuildContext context, int index){
        return Container(
            height: 20,
            child: Divider(height: 5));},
      itemBuilder: (BuildContext context, int index) {
        return index > 2 ? ResultTile(_restaurant[index], index) : TopResultTile(_restaurant[index], index);
      },
    );
  }
}