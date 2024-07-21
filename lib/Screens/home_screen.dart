import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iclick_flutter_practical_test/Block/book_block.dart';
import 'package:iclick_flutter_practical_test/Block/book_event.dart';
import 'package:iclick_flutter_practical_test/Block/book_state.dart';
import 'package:iclick_flutter_practical_test/Screens/favorite_screen.dart';
import 'package:iclick_flutter_practical_test/Widgets/book_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(const FetchBooks());
    _searchController.addListener(_onSearchQueryChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchQueryChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchQueryChanged() {
    final query = _searchController.text;
    context.read<BookBloc>().add(FilterBooks(query));
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<BookBloc>().add(const FetchBooks());
  }

  Future<void> _navigateToFavorites() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<BookBloc>(context),
          child: const FavoritesScreen(),
        ),
      ),
    );
    context.read<BookBloc>().add(const FetchBooks()); // Fetch all books again
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IT Bookstore'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: _navigateToFavorites,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Title',
                border: const OutlineInputBorder(),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BookLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookLoaded) {
                  return BookList(books: state.books);
                } else if (state is BookError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No books available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}