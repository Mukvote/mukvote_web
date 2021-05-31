import 'package:flutter/material.dart';
import 'result.dart';
import 'class/item.dart';

var items = List<Item>.generate(15, (index) {
  int i = index % 3;
  return Item(
    restName: 'restaurant' + '$index',
    peopleNum: index + i,
    checked: false,
  );
});

class ItemTile extends StatefulWidget{
  ItemTile(this._item);
  final Item _item;

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: (widget._item.checked) ? Icon(Icons.check, color: Colors.deepPurpleAccent,) : Icon(Icons.lens_outlined),
        onPressed: (){
          setState(() {
            widget._item.checked ? widget._item.checked = false : widget._item.checked = true;
            widget._item.checked ? widget._item.peopleNum++ : widget._item.peopleNum--;
          });
        },
      ),
      title: Text(widget._item.restName, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: (widget._item.checked) ? Colors.deepPurpleAccent : Colors.black45),),
      trailing: Text('${widget._item.peopleNum}', style: TextStyle(fontSize: 16, color: (widget._item.checked) ? Colors.deepPurpleAccent : Colors.black45),),
    );
  }
}

class VotePage extends StatefulWidget{
  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
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
        body:SingleChildScrollView(
          child: Column(
            children: [
              ItemBuilder(),
              SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push( context, MaterialPageRoute(
                    builder: (context) => ResultPage(items),
                  ),
                  );
                },
                child: Text(
                  '투표하기',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 15, 50, 15)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepPurpleAccent),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          //side: BorderSide(color: Colors.red)
                        ))),
              ),
              SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}


class ItemBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      // itemCount: items.length + 1,
      itemCount: items.length,
      separatorBuilder: (BuildContext context, int index){
        return Container(
          height: 20,
            child: Divider(height: 5));},
      itemBuilder: (BuildContext context, int index) {
        return ItemTile(items[index]);
      },
    );
  }
}