import 'package:flutter/material.dart';
import 'package:baddog_flutter/models/data/media/article_model.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({Key? key, required this.card}) : super(key: key);
  final Article card;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: Image(
                width: 96,
                image: NetworkImage(card.image),
              ),
              title: Text(
                card.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                card.description,
                overflow: TextOverflow.fade,
                maxLines: 3,
              ),
              trailing: Column(),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
