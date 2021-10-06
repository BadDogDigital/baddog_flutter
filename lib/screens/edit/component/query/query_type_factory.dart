import 'package:baddog_flutter/screens/edit/component/query/templates/news_query_edit.dart';
import 'package:flutter/material.dart';

//We will need to split this into news and news type I think
//We'll end up with thousands of queries regardless
//We are literally just going to have to make an edit widget for each query
//That's just how it is
class EditComponentQueryFactory {
  static Widget getTemplate({required typeId, required data}) {
    //default return
    //probably split by type news, etc -> then specifics
    //returning some 404 if errors
    if (data['query_id'] == 'gnews_search')
      return NewsQueryTemplate(data: data);

    return Text('Unfound Parameters template');
  }
}
