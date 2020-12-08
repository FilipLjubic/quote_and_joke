class Quote {
  String quote;
  String author;
  String authorShort;

  Quote({this.quote, this.author, this.authorShort});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
        author: json['author'],
        quote: json['content'],
        authorShort: _createShortAuthor(json["author"]));
  }

  static String _createShortAuthor(String author) {
    List<String> nameSurname = author.split(" ");
    return nameSurname[nameSurname.length - 1];
  }
}
