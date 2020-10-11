class QuoteModel {
  String quote;
  String author;
  String authorShort;

  QuoteModel({this.quote, this.author, this.authorShort});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
        author: json['author'],
        quote: json['content'],
        authorShort: _createShortAuthor(json["author"]));
  }

  static String _createShortAuthor(String author) {
    List<String> nameSurname = author.split(" ");
    return nameSurname[nameSurname.length - 1];
  }
}
