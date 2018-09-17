import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'countries.dart';

class SearchBloc {
  final _query = BehaviorSubject<String>();
  final _results = BehaviorSubject<List<String>>();

  Stream<List<String>> get results => _results.stream;

  Function(String) get changeQuery => _query.sink.add;

  // -----------------
  // debounce =>
  // only emit items from the source sequence
  // if a particular time span has passed without the source sequence emitting
  // another item.

  // USE CASE:
  // This is to avoid unnecessary network calls. Imagine search method is making
  // an api request. It will be expensive to make a network call for every change
  // in the search field.

  // -----------------
  // distinct =>
  // data events are skipped if they are equal to the previous data event

  // USE CASE:
  // Good combo with debounce. Imagine you type "tur" and then stop, time span
  // passed, the result is returned. Then you start typing "turkey" and then
  // without stopping you delete up to "tur", in that case debounce will return
  // "tur" again and because you already got the result, no need to make another
  // call with same query. So distinct won't emit this last one because it's
  // equal to previous one.

  SearchBloc() {
    _query.stream
        .debounce(Duration(milliseconds: 300))
        .distinct()
        .listen((String query) {
      search(query);
    });
  }

  //You could also turn query to lowercase with map before listening stream
  void search(String query) {
    print(query);
    List<String> results = listOfCountries
        .where((String country) =>
            country.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    _results.add(results);
  }

  void dispose() {
    _query.close();
    _results.close();
  }
}
