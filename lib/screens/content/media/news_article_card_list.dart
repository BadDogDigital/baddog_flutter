import 'package:baddog_flutter/models/data/media/article_model.dart';
import 'package:baddog_flutter/screens/content/base/gql_query_mixin.dart';
import 'package:baddog_flutter/screens/content/media/news/ArticleCard.dart';
import 'package:flutter/material.dart';

///Our first query dependant list
///This should form the basis of all GridItemObjects
///This could be created as a generic thing
///Specify use passed function on query completion
///get function from service or factory function
///We don't even need to copy and paste the thing
///just make new widgets!
///
/////This should just be card list
class NewsArticleCardList extends StatefulWidget {
  const NewsArticleCardList({
    Key? key,
    //do we need these?
    //We need params for setup or however
    //we need data
    required this.params,
    required this.query,
    required this.type,
    required this.data,
  }) : super(key: key);

  //perhaps should move / create a initObject
  //But if we have a known set of inputs
  ////We can make a uniform wrapper / or at least uniform to a related set
  final Map query;
  final Map params;
  final Map type;
  final Map data;

  @override
  _NewsArticleCardListState createState() => _NewsArticleCardListState();
}

class _NewsArticleCardListState extends State<NewsArticleCardList> {
  final String itemType = 'Card';

  //Theoretically this function could be included in a factory
  //Or from a library
  //NewsArticleCardList - i.e. this class could be a generic wrapper
  //So buildMyWidget returns a builder that takes data that's all
  //Don't mess aroud with anything other than creating components
  Widget buildArticlesWidget() {
    var articles = widget.data['articles'];

    return createArticleCards(articles); //Call from library
  }

  //filter type - create cards, create intros,
  Widget createArticleCards(articles) {
    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final item = Article(data: articles[index]);
          //load according to - using the same data?
          //maybe a step too far but seems legit

          if (itemType == 'Card') return ArticleCard(card: item);
          if (itemType == 'Intro') return createArticleIntro(item);

          //default
          return ArticleCard(card: item); //createArticleCard(item);
        });
  }

  Widget createArticleIntro(card) {
    return Text(
      card.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("We're here!!!");
    //queryObject = createQueryObject();
    //queryData = widget.query;
    //buildWidget = buildArticlesWidget;
    //This could actually be generic
    //It is just a list
    return buildArticlesWidget(); //buildQueryWidget(context);
  }
}
