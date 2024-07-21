import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iclick_flutter_practical_test/Block/book_block.dart';
import 'package:iclick_flutter_practical_test/Block/book_event.dart';
import 'package:iclick_flutter_practical_test/Block/book_state.dart';
import 'package:iclick_flutter_practical_test/Model/book.dart';
import 'package:iclick_flutter_practical_test/Screens/details_screen.dart';


class BookList extends StatefulWidget {
  final List<Book> books;

  const BookList({Key? key, required this.books}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.books.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey.shade300,
        thickness: 1,
        height: 1,
      ),
      itemBuilder: (context, index) {
        final book = widget.books[index];
        return BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            bool isFavorite = false;
            if (state is BookLoaded) {
              isFavorite = state.favoriteBooks.contains(book);
            }
            return ListTile(
              leading: ClipOval(
                child: Container(
                  color: Colors.grey.shade200,
                  child: Image.network(
                    book.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(book.title),
              subtitle: Text(book.subtitle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(book: book),
                  ),
                );
              },
              trailing: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  context.read<BookBloc>().add(ToggleFavorite(book));
                  setState(() {}); // Force UI update
                },
              ),
            );
          },
        );
      },
    );
  }
}