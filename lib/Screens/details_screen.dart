import 'package:flutter/material.dart';
import 'package:iclick_flutter_practical_test/Model/book.dart';

class DetailsScreen extends StatelessWidget {
  final Book book;

  const DetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  book.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
              ],
            ),
            const SizedBox(height: 30), // Gap between image and title
            Text(
              book.title,
              //style: Theme.of(context).textTheme.bodySmall ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),
            ),
            const SizedBox(height: 8),
            Text(
              book.subtitle,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,),
            ),
            const SizedBox(height: 16),
            Text(book.price,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,),
            ),
            const SizedBox(height: 16),
            Text(
              'Rating: ${book.isbn13}', // Assuming isbn13 as rating; update if actual rating available
               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,),
            ),
            const SizedBox(height: 16),
            Text(
              'Description: ${book.subtitle}', // Assuming subtitle as description; update if actual description available
               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black,),
            ),
          ],
        ),
      ),
    );
  }
}