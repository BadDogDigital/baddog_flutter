import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphAppWrapper extends StatelessWidget {
  const GraphAppWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final HttpLink link = HttpLink("http://localhost:4000");
    ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      cache: GraphQLCache(), //store: HiveStore()
      link: link,
    ));
    return GraphQLProvider(
      client: client, //passed in App
      child: child,
    );
  }
}
