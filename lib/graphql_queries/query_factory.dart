import 'package:baddog_flutter/graphql_queries/news/main_queries.dart';

class QueryFactory {
  static Map<String, String> getQuery({required type, required id}) {
    if (type == 'News') {
      //data? / yeah how to do well?
      if (id == 'search') return NewsQuery.search();
      if (id == 'headlines') return NewsQuery.headlines();

      //default return
      return {'error': 'No query of that id available'};
    }

    //default return
    return {'error': 'No query library of that type'};
  }
}
