import 'package:flutter/material.dart';
import 'package:baddog_flutter/graphql_queries/news/main_queries.dart';

//import 'package:graphql_flutter/graphql_flutter.dart';
//import 'dart:convert';

import 'package:baddog_flutter/widgets/query/baddog_griditem_query.dart';
//Hover/hold for basic info
//tap to go to

//The real question sems to be how do we have swipe functionality
//for individual Grid Items
//but ALSO swipe gestures to move on to the next gridItem
//Like FlickBoard we can animate individual jazz
//i.e. flick a youtube video away and onto the next one

//Select and interact this side
//but use an actual 'item' flick at the boundaries
//Fully transparent just a control

class DummyQuery extends StatefulWidget {
  DummyQuery({
    Key? key,
    this.color = Colors.red,
  }) : super(key: key);

  final Color color;

  @override
  _DummyQueryState createState() => _DummyQueryState();
}

class _DummyQueryState extends State<DummyQuery> {
  //final gnewsSearchQ = 'Afghanistan';
  //final String gnewsSearchQ = 'Afghanistan';

  @override
  Widget build(BuildContext context) {
    //load query/string from elsewheres
    //i.e. news queries utils for all available
    //specific files for granularity
    //querySchema

    //load from query service
    //pass in params (aVariableBool) to create String
    //return the string as our query from a list of available queries

    //input skip or include = true
    final queryName = 'gnews_headlines';
    //return a specific object?
    final Map<String, String> myFirstQuery =
        NewsQuery.headlines(target: queryName);

    final q = myFirstQuery['query'] ?? '';
    final type = myFirstQuery['type'] ?? '';

    final queryVars = {
      "q": "Brexit",
      "lang": "en",
    };

    var returnWidget = 'Text';
    var returnWidgetParams = {"aParameter": "Hello"};

    ///GraphQLProvider should wrap the 'top level' widget - that all queries are below
    return Container(
      color: this.widget.color,
      //child: Icon(Zocial.twitter),
      child: BadDogQuery(
        query: q,
        variables: queryVars,
        returnWidget: returnWidget, //as an id
        widgetParams: returnWidgetParams,
        queryName: type,
      ),
      //onTap: () => print("Tapped!"),
      //),
    );
    //);
  }
}
