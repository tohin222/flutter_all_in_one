import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  Widget appTitle = Text('Search',style: TextStyle(color: Colors.white),);
  Icon actionIcon = Icon(Icons.search,color: Colors.white,);
  final TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _searchingText = '';
  bool _isSearching;
  List<String> _list;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearching = false;
    initData();
  }

  void initData(){
    _list = List();
    _list.add('google');
    _list.add('facebook');
    _list.add('yahoo');
    _list.add('instaGram');
  }
  _SearchPageState(){
  _searchController.addListener((){
    if(_searchController.text.isEmpty){
     setState(() {
       _isSearching = false;
       _searchingText = '';
     });
    }
    else{
     setState(() {
       _isSearching = true;
       _searchingText = _searchController.text;
     });
    }
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: myBuildBar(context),
      body: ListView(
        children: _isSearching ? _buildListItem() : _buildItem(),
      ),

    );
  }

  Widget myBuildBar(BuildContext context){
    return AppBar(
      centerTitle: true,
      title: appTitle,
      actions: <Widget>[
        IconButton(icon: actionIcon, onPressed: (){
          setState(() {
            if(this.actionIcon.icon == Icons.search){
              this.appTitle = TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Type your Name'
                ),
              );
              this.actionIcon = Icon(Icons.clear);
              _handleStart();
            }
            else{
              _handleEnd();
            }
          });
        })
      ],
    );

  }
  void _handleStart(){
    setState(() {
      _isSearching = true;
    });
  }
  void _handleEnd(){
    setState(() {
      this.appTitle = Text('Search');
      this.actionIcon= Icon(Icons.search);
      _isSearching = false;
      _searchController.clear();
    });
  }
List<MyItem> _buildItem(){
  return _list.map((contact)=> MyItem(contact)).toList();
}
List<MyItem> _buildListItem(){
  if (_searchingText.isEmpty) {
    return _list.map((contact) => new MyItem(contact))
        .toList();
  }
  else {
    List<String> _searchList = List();
    for (int i = 0; i < _list.length; i++) {
      String  name = _list.elementAt(i);
      if (name.toLowerCase().contains(_searchingText.toLowerCase())) {
        _searchList.add(name);
      }
    }
    return _searchList.map((contact) => new MyItem(contact))
        .toList();
  }
}
}

class MyItem extends StatelessWidget {
  final String name;
  MyItem(this.name);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
    );
  }
}
