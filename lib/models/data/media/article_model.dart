class Article {
  Map data;
  String title;
  String description;
  String content;
  String url;
  String image;
  String published;
  Source source;

  Article({required this.data})
      : title = data['title'],
        description = data['description'],
        content = data['content'],
        url = data['url'],
        image = data['image'],
        published = data['published'],
        source = Source(data: data['source']);
}

//Okay yeah!
class Source {
  Map data;
  String name;
  String url;
  Source({required this.data})
      : name = data['author'],
        url = data['url'];
}
