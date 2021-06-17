import 'package:flutter/material.dart';
import 'vote_page.dart';

class MenuListPage extends StatefulWidget {
  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {

  @override
  Widget build(BuildContext context) {

    //리스트 나중에 삭제하기!!
    List<Restaurant> rList =
    List<Restaurant>.generate(3, (int index) => Restaurant(name: index.toString(),id: index, place: 'a', category: '한식', priority: 0));
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.deepPurpleAccent, // add custom icons also
            ),
          ),
          title: Text('먹VOTE',
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          //backgroundColor: Color(0xff5808e5),
          bottom: TabBar(
            labelColor: Colors.deepPurpleAccent,
            indicatorColor: Colors.deepPurpleAccent,
            tabs: [
              Tab(text: '양덕'),
              Tab(text: '법원'),
              Tab(text: '영일대'),
              Tab(text: '배달'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Center(child: Text('양덕리스트')),
            ListView(children: [YangdukBuilder(rList)]),
            Center(child: Text('법원')),
            Center(child: Text('영일대')),
            Center(child: Text('배달')),
          ],
        ),
      ),
    );
  }
}

class YangdukBuilder extends StatelessWidget {
  YangdukBuilder(this.restaurantItems);
  var restaurantItems;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      // itemCount: items.length + 1,
      itemCount: restaurantItems.length,
      separatorBuilder: (BuildContext context, int index){
        return Container(
            height: 20,
            child: Divider(height: 5));},
      itemBuilder: (BuildContext context, int index) {
        // return ShowRestaurant(restaurantItems[index]);
        return ListTile(
          title: Text(restaurantItems[index].name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),),
          trailing: Text(restaurantItems[index].category, style: TextStyle(fontSize: 16, color: Colors.deepPurpleAccent,),
        ));
      },
    );
  }
}