//I guess split factories for use??
import 'package:baddog_flutter/screens/content/wrapper/gql_query_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:baddog_flutter/screens/content/media/news_article_card_list.dart';

///Simple factory function
///Choose Widget pass in json object including query return
class GridItemFactory {
  ///Return a Content Widget
  ///Use given data and parameters to construct
  ///need pass in any services
  static Widget createGridItemView({
    required Map type,
    required Map params,
    required Map data,
    Map? query,
  }) {
    //use //json_serializable implement objects by passing in received json
    //i.e. for each article
    var queryData = query ?? {'': ''};

    //need default / placeholder / 404
    var id = type['type'];

    //should pass in an initObject
    //Should be in its own class / file
    if (id == 'NewsArticleCardList') //this is what it should be no?
      return NewsArticleCardList(
          params: params, query: queryData, type: type, data: data);

    return Text('There was a problem :/'); //return 404 item page
  }

  //Return Content wrapper type
  //Different query return / data from user list / static / etc
  static Widget createGridItemWrapper(
      {required Map type, required Map params, Map? query}) {
    var queryData = query ?? {'': ''};
    var id = type['wrapper'];
    if (id == 'GQLQueryWrapper')
      return GQLQueryWrapper(params: params, query: queryData, type: type);

    return Text('There was a problem :/');
  }
}
