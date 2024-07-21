import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String title;
  final String subtitle;
  final String authors;
  final String publisher;
  final String isbn13;
  final String price;
  final String image;
  final String url;

  Book({
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.publisher,
    required this.isbn13,
    required this.price,
    required this.image,
    required this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      authors: json['authors'] ?? '',
      publisher: json['publisher'] ?? '',
      isbn13: json['isbn13'] ?? '',
      price: json['price'] ?? '',
      image: json['image'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'publisher': publisher,
      'isbn13': isbn13,
      'price': price,
      'image': image,
      'url': url,
    };
  }

  @override
  List<Object> get props => [title, subtitle, authors, publisher, isbn13, price, image, url];
}