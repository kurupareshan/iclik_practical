import 'package:equatable/equatable.dart';
import 'package:iclick_flutter_practical_test/Model/book.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;
  final List<Book> favoriteBooks;

  const BookLoaded({required this.books, required this.favoriteBooks});

  @override
  List<Object> get props => [books, favoriteBooks];
}

class BookError extends BookState {
  final String message;

  const BookError({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteBooks extends BookState {
  final List<Book> favoriteBooks;

  const FavoriteBooks({required this.favoriteBooks});

  @override
  List<Object> get props => [favoriteBooks];
}
