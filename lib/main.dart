import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iclick_flutter_practical_test/Block/book_block.dart';
import 'package:iclick_flutter_practical_test/Block/book_event.dart';
import 'package:iclick_flutter_practical_test/Repository/book_repository.dart';
import 'package:iclick_flutter_practical_test/Screens/home_screen.dart';

void main() {
  final BookRepository bookRepository = BookRepository();
  runApp(MyApp(bookRepository: bookRepository));
}

class MyApp extends StatelessWidget {
  final BookRepository bookRepository;

  const MyApp({Key? key, required this.bookRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc(bookRepository)..add(FetchBooks()),
      child: MaterialApp(
        title: 'IT Bookstore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
