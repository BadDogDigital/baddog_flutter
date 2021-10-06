import 'package:baddog_flutter/graphql_queries/query_factory.dart';
import 'package:baddog_flutter/widgets/grid/factory/grid_item_factory.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

///THIS IS DEFUNCT !!!
///NOT USED - QUERY WRAPPER INSTEAD

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

mixin GQLQueryDispatch {
  late Widget _buildWidget;
  get buildWidget => _buildWidget;
  set buildWidget(buildWidget) {
    _buildWidget = buildWidget;
  }

  late Map _queryData;
  get queryData => _queryData;
  set queryData(queryData) {
    _queryData = queryData;
  }

  late QueryObject _queryObject;
  get queryObject => _queryObject;
  set queryObject(queryObject) {
    _queryObject = queryObject;
  }

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
    var obj = _buildWidget;

    //pass here to ArticlesReturn Model / there creating the full data model?
    return _buildWidget;
    //(queryObject.data);
  }

  Widget createBuildWidget() {
    return Container();
    //GridItemFactory.createGridItemView(
    //    type: widget.type,
    //    params: widget.params,
    //   query: widget.query,
    //   data: {'': ''});
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
    queryObject = createQueryObject();
    //_query_id = queryObject.type;
    var queryOptions = QueryOptions(
      document: gql(queryObject.query),
      variables: queryObject.parameters,
    );
    return Query(
      options: queryOptions,
      builder: createQuery, //can we pass a function in here?
    );
  }
}
