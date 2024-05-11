/* import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Datos simulados (pueden ser datos reales de una API)
  final List<String> items = List.generate(100, (index) => 'Elemento $index');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Paginación en Flutter'),
        ),
        body: PaginatedListView(items: items),
      ),
    );
  }
}

class PaginatedListView extends StatefulWidget {
  final List<String> items;

  const PaginatedListView({Key key, @required this.items}) : super(key: key);

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  ScrollController _scrollController = ScrollController();
  List<String> _pagedItems = [];
  int _currentPage = 1;
  int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadPage(_currentPage);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadPage(_currentPage + 1);
    }
  }

  void _loadPage(int page) {
    int startIndex = (page - 1) * _pageSize;
    int endIndex = startIndex + _pageSize;
    if (startIndex < widget.items.length) {
      setState(() {
        _pagedItems.addAll(widget.items.getRange(startIndex, endIndex));
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _pagedItems.length + 1,
      itemBuilder: (context, index) {
        if (index == _pagedItems.length) {
          return _buildLoader();
        } else {
          return ListTile(
            title: Text(_pagedItems[index]),
          );
        }
      },
    );
  }

  Widget _buildLoader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
 */