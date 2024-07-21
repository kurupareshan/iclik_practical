import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iclick_flutter_practical_test/Block/book_block.dart';
import 'package:iclick_flutter_practical_test/Block/book_event.dart';
import 'package:iclick_flutter_practical_test/Block/book_state.dart';
import 'package:iclick_flutter_practical_test/Widgets/book_list.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookBloc>().add(LoadFavorites());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
        centerTitle: true,
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is FavoriteBooks) {
            return BookList(books: state.favoriteBooks);
          } else if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('No favorite books available'));
          }
        },
      ),
    );
  }
}
