import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:baddog_flutter/widgets/grid/factory/grid_item_factory.dart';

//Make a class Object for ContentPage
//Need uniform aproach

class BadDogQuery extends StatefulWidget {
  const BadDogQuery({
    Key? key,
    required this.query,
    required this.variables,
    required this.returnWidget,
    required this.widgetParams,
    required this.queryName,
  }) : super(key: key);
  final String query;
  final Map<String, String> variables;
  final String returnWidget;
  final Map<String, String> widgetParams;
  final String queryName;

  @override
  _BadDogQueryState createState() => _BadDogQueryState();
}

class _BadDogQueryState extends State<BadDogQuery> {
  Widget createQuery(QueryResult result,
      {VoidCallback? refetch, FetchMore? fetchMore}) {
    var refetchQuery = refetch; //pagination?
    if (result.hasException) {
      //We need to flag/log and load a back up
      return Text(result.exception.toString());
    }
    if (result.isLoading) {
      return Text('Loading');
    }
    //if(result.data![widget.queryName])//if no need err
    //print(result.data![widget.queryName]['totalArticles']);

    //I think you have to know what you've searched for and pass it down
    /*result.data![widget.queryName].forEach((key, value) {
      print(key);
      print(value);
    });*/
    //We wouldn't use object notation but we can create objects to type
    var queryData = result.data![widget.queryName];
    //List articles = result.data![widget.queryName]['articles'];
    //print('articles length ${articles.length}');

    //Goddam here is the thing
    //call a factory class and pass in type id
    //pass in data to create
    //return createFactory(widget.returnWidget, widget.widgetParams);

    //if not made make - if made reset
    return Container();
    /*GridItemFactory.createGridItemView(
      type: widget.returnWidget,
      params: widget.widgetParams,
      query: queryData,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    var queryOptions = QueryOptions(
      document: gql(widget.query),
      variables: widget.variables,
    );
    return Query(
      options: queryOptions,
      builder: createQuery, //can we pass a function in here?
    );
  }
}
