//You don't need to know this in client
//static call NEWS
class GNews {
  static String gnewsSearchQuery(
    bool totalArticles,
    bool articles,
    bool title,
    bool description,
    bool content,
    bool url,
    bool image,
    bool publishedAt,
    bool source,
    bool sourcename,
    bool sourceurl,
  ) {
    return """
      query Query(\$q: String, \$lang: String) {
        gnews_search(q: \$q, lang: \$lang) {
          totalArticles @include(if: $totalArticles)
          articles @include(if: $articles) {
            title @include(if: $title)
            description @include(if: $description)
            content @skip(if: $content)
            url @include(if: $url)
            image @include(if: $image)
            publishedAt @include(if: $publishedAt)
            source @include(if: $source) {
              name @include(if: $sourcename)
              url @include(if: $sourceurl)
            }
          }
        }
      }
    """;
  }
}
