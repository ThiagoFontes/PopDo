import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'My Flutter Pad'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

const kExpandedHeight = 300.0;

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener((){
        final isNotExpanded = _scrollController.hasClients && _scrollController.offset > kExpandedHeight - (kToolbarHeight + 100);
        if (isNotExpanded != _showTitle){
          setState(() {
            _showTitle = isNotExpanded;
          });
        }
      });
  }

  bool _showTitle = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              snap: false,
              elevation: 0.0,
              title: _showTitle ? Text('Collapsed Toolbar') : null,
              centerTitle: true,
              flexibleSpace: _showTitle ? null : FlexibleSpaceBar(
                centerTitle: false,
                title: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Sliver Appbar'),
                    Text('subtitle'),
                  ],
                ),
                background: Image(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topRight,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                Column(
                  children: <Widget>[
                    Text("s")
                  ],
                )
              ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(List<Text>.generate(50, (int i) {
                return Text("List item $i");
              })),
            ),
          ]
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._column);

  final Column _column;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _column,
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;

  @override
  // TODO: implement minExtent
  double get minExtent => 20;
}