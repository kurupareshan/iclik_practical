import 'dart:convert';
import 'package:iclick_flutter_practical_test/Block/book_event.dart';
import 'package:iclick_flutter_practical_test/Block/book_state.dart';
import 'package:iclick_flutter_practical_test/Model/book.dart';
import 'package:iclick_flutter_practical_test/Repository/book_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;
  List<Book> allBooks = [];
  List<Book> favoriteBooks = [];

  BookBloc(this.bookRepository) : super(BookInitial()) {
    on<FetchBooks>((event, emit) async {
      emit(BookLoading());
      try {
        allBooks = await bookRepository.fetchBooks();
        await _loadFavorites();
        emit(BookLoaded(books: allBooks, favoriteBooks: favoriteBooks));
      } catch (e) {
        emit(BookError(message: 'Failed to fetch books: $e'));
      }
    });

    on<FilterBooks>((event, emit) {
      final query = event.query.toLowerCase();
      final filteredBooks = allBooks.where((book) {
        final title = book.title.toLowerCase();
        return title.contains(query);
      }).toList();
      emit(BookLoaded(books: filteredBooks, favoriteBooks: favoriteBooks));
    });

    on<ToggleFavorite>((event, emit) async {
      if (favoriteBooks.contains(event.book)) {
        favoriteBooks.remove(event.book);
      } else {
        favoriteBooks.add(event.book);
      }
      await _saveFavorites();
      allBooks = await bookRepository.fetchBooks();
      await _loadFavorites();
      emit(BookLoaded(books: allBooks, favoriteBooks: favoriteBooks));  // Emit BookLoaded to update the UI
    });

    on<LoadFavorites>((event, emit) async {
      await _loadFavorites();
      emit(FavoriteBooks(favoriteBooks: favoriteBooks));
    });
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson = favoriteBooks.map((book) => jsonEncode(book.toJson())).toList();
    prefs.setStringList('favoriteBooks', favoriteJson);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteJson = prefs.getStringList('favoriteBooks') ?? [];
    favoriteBooks = favoriteJson.map((jsonString) => Book.fromJson(jsonDecode(jsonString))).toList();
  }
}
