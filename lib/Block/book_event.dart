import 'package:equatable/equatable.dart';
import 'package:iclick_flutter_practical_test/Model/book.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class FetchBooks extends BookEvent {
  const FetchBooks();

  @override
  List<Object> get props => [];
}

class ToggleFavorite extends BookEvent {
  final Book book;

  const ToggleFavorite(this.book);

  @override
  List<Object> get props => [book];
}

class LoadFavorites extends BookEvent {}

class FilterBooks extends BookEvent {
  final String query;

  const FilterBooks(this.query);

  @override
  List<Object> get props => [query];
}