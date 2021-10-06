//import 'package:baddog_flutter/graphql_queries/news/gnews_api/gnews_queries.dart';

class NewsQuery {
//this is bitty but structurely there
//I think we would need a generic query for generic requests/responses
//but targetted queries available for everything

//We can catch a query on the way in
//Take the generic given parameters
//and modify to suit us
  ////////////////////////////////
  ///news api main search method
  static Map<String, String> search({
    String target =
        'gnews_search', //would you do this? specify api? and or mix?
    bool totalArticles = true,
    bool articles = true,
    bool title = true,
    bool description = true,
    bool content = true,
    bool url = true,
    bool image = true,
    bool publishedAt = true,
    bool source = true,
    bool sourcename = true,
    bool sourceurl = true,
  }) {
    //there has to be a better way of doing queries
    return {
      'type': target,
      'query': """
        query Query(\$q: String, \$lang: String, \$country: String, \$max: Int, \$page: Int, \$in: String, \$nullable: String, \$from: String, \$to: String, \$sortby: String, \$expand: String) {
          $target(q: \$q, lang: \$lang, country: \$country, max: \$max, page: \$page, in: \$in, nullable: \$nullable, from: \$from, to: \$to, sortby: \$sortby, expand: \$expand) {
            total @include(if: $totalArticles)
            articles @include(if: $articles) {
              title @include(if: $title)
              description @include(if: $description)
              content @include(if: $content)
              url @include(if: $url)
              image @include(if: $image)
              published @include(if: $publishedAt)
              source @include(if: $source) {
                author @include(if: $sourcename)
                url @include(if: $sourceurl)
              }
            }
          }
        }
      """
    };
  }

  ////////////////////////////////
  ///news api main headlines method
  static Map<String, String> headlines({
    //latest?
    String target =
        'gnews_headlines', //would you do this? specify api? and or mix?
    bool totalArticles = true,
    bool articles = true,
    bool title = true,
    bool description = true,
    bool content = true,
    bool url = true,
    bool image = true,
    bool publishedAt = true,
    bool source = true,
    bool sourcename = true,
    bool sourceurl = true,
  }) {
    //this feels scrappy
    return {
      'type': target,
      'query': """
        query Query(\$q: String, \$topic: String, \$lang: String, \$country: String, \$max: Int, \$page: Int, \$nullable: String, \$from: String, \$to: String, \$expand: String) {
          $target(q: \$q, topic: \$topic, lang: \$lang, country: \$country, max: \$max, page: \$page, nullable: \$nullable, from: \$from, to: \$to, expand: \$expand) {
            total @include(if: $totalArticles)
            articles @include(if: $articles) {
              title @include(if: $title)
              description @include(if: $description)
              content @include(if: $content)
              url @include(if: $url)
              image @include(if: $image)
              published @include(if: $publishedAt)
              source @include(if: $source) {
                author @include(if: $sourcename)
                url @include(if: $sourceurl)
              }
            }
          }
        }
      """
    };
  }
}
