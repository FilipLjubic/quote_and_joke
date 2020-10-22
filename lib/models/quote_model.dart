class Quote {
  String quote;
  String author;
  String authorShort;

  Quote({this.quote, this.author, this.authorShort});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
        author: json['author'],
        quote: json['content'],
        authorShort: createShortAuthor(json["author"]));
  }

  static String createShortAuthor(String author) {
    List<String> nameSurname = author.split(" ");
    return nameSurname[nameSurname.length - 1];
  }
}
