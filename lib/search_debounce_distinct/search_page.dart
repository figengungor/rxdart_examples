import 'package:flutter/material.dart';
import 'package:rxdart_examples/search_debounce_distinct/search_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  SearchBloc _bloc;

  @override
  void initState() {
    _bloc = SearchBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: _buildBody(),
    );
  }

  _buildBody() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _buildSearchField(),
            _buildResultListView(),
          ],
        ),
      );

  _buildSearchField() => TextField(
        decoration: InputDecoration(
          hintText: 'Search your country',
          prefixIcon: Icon(Icons.flag),
        ),
        onChanged: _bloc.changeQuery,
      );

  _buildResultListView() => Expanded(
        child: StreamBuilder(
          stream: _bloc.results,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text(snapshot.data[index]));
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Container();
            }
          },
        ),
      );
}
