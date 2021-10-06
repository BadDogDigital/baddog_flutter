import 'package:baddog_flutter/graphql_queries/query_factory.dart';
import 'package:baddog_flutter/widgets/grid/factory/grid_item_factory.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QueryObject {
  final String query;
  final String type;
  Map? data;
  final Map<String, dynamic> parameters;
  QueryObject({
    required this.query,
    required this.type,
    required this.parameters,
    this.data,
  });
}

///Our first query dependant list
///This should form the basis of all GridItemObjects
///This could be created as a generic thing
///Specify use passed function on query completion
///get function from service or factory function
///We don't even need to copy and paste the thing
///just make new widgets!
class GQLQueryWrapper extends StatefulWidget {
  const GQLQueryWrapper(
      {Key? key, required this.params, required this.query, required this.type})
      : super(key: key);

  //perhaps should move / create a initObject
  //But if we have a known set of inputs
  ////We can make a uniform wrapper / or at least uniform to a related set
  final Map query;
  final Map params;

  ///type contains widget types - on error use this widget, loading this widget
  final Map type;

  @override
  _GQLQueryWrapperState createState() => _GQLQueryWrapperState();
}

class _GQLQueryWrapperState extends State<GQLQueryWrapper> {
  //late Widget _buildWidget;

  late Map _queryData;

  late QueryObject _queryObject;

  Widget createQuery(QueryResult result,
      {VoidCallback? refetch, FetchMore? fetchMore}) {
    var refetchQuery = refetch; //pagination?
    //input error widget
    if (result.hasException) {
      //We need to flag/log and load a back up
      return Text(result.exception.toString());
    }
    //input loading widget
    if (result.isLoading) {
      return Text('Loading');
    }

    //queryData = result.data![queryObject.type];
    _queryObject.data = result.data![_queryObject.type];
    //var obj = _buildWidget;

    return createBuildWidget(result.data![_queryObject.type]);
  }

  Widget createBuildWidget(Map dta) {
    return GridItemFactory.createGridItemView(
      type: widget.type,
      params: widget.params,
      query: widget.query,
      data: dta,
    );
  }

  QueryObject createQueryObject() {
    final Map qObj =
        QueryFactory.getQuery(type: _queryData['type'], id: _queryData['name']);
    return QueryObject(
      query: qObj['query'] ?? '',
      type: qObj['type'] ?? '',
      parameters: _queryData['parameters'],
    );
  }

  Widget buildQueryWidget(BuildContext context) {
    _queryObject = createQueryObject();
    //_query_id = queryObject.type;
    var queryOptions = QueryOptions(
      document: gql(_queryObject.query),
      //we're passing extra parameters
      variables: _queryObject.parameters,
    );
    return Query(
      options: queryOptions,
      builder: createQuery,
    );
  }

  @override
  Widget build(BuildContext context) {
    //queryObject = createQueryObject();
    _queryData = widget.query;

    return buildQueryWidget(context);
  }
}
