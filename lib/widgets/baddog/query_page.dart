import 'package:flutter/material.dart';
import 'package:baddog_flutter/graphql_queries/news/main_queries.dart';

import 'package:baddog_flutter/widgets/query/baddog_griditem_query.dart';
import 'package:baddog_flutter/graphql_queries/query_factory.dart';

class QueryPage extends StatefulWidget {
  QueryPage({Key? key, required this.data}) : super(key: key);

  final Map data;

  @override
  _QueryPageState createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  @override
  Widget build(BuildContext context) {
    final queryName = widget.data['query_name'];

    //needs to be more dynamic I think
    //how do we target NEWS 'headlines' a hash I suppose inside the thing
    //again just a simple factory function will do this simple & effective
    //ping info to a Query class and return

    //final Map<String, String> myFirstQuery =
    //    NewsQuery.headlines(target: queryName);

    //retutns with no filters applied at the moment which is fine for now
    //needs sorting out ultimately - can only think of a long winded sollution at the mo
    final Map myFirstQuery = QueryFactory.getQuery(type: 'News', id: 'search');
    //you need a fromJson for each query I reckon

    final q = myFirstQuery['query'] ?? '';
    final type = myFirstQuery['type'] ?? '';

    final queryVars = widget.data['query_variables'];

    var returnWidget = widget.data['return_widget'];
    var returnWidgetParams = widget.data['widget_params'];

    //Create a proper widget I suppose
    return Container(
      color: Colors.pink,
      width: double.infinity,
      height: double.infinity,
      child: BadDogQuery(
        query: q,
        variables: queryVars,
        returnWidget: returnWidget, //as an id
        widgetParams: returnWidgetParams,
        queryName: type,
      ),
    );
  }
}
