import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';
import 'package:my_books_app/core/loader/overlay_service.dart';
import 'package:my_books_app/core/navigator/app_navigator.dart';
import 'package:my_books_app/data/model/book/book_model.dart';
import 'package:my_books_app/data/model/book/get_book_list_resp_model.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/repository/book/book_repository_impl.dart';
import 'package:my_books_app/domain/book/book_repository.dart';
import 'package:my_books_app/presentation/book_detail/book_detail_screen.dart';

class BookListScreen extends StatelessWidget {
  final BookRepository bookRepository = BookRepositoryImpl();
  BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.white
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text('Book List',style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold),),
     
      ),
        body: StreamBuilder(
          stream: bookRepository.getBooksStream(),
          builder: (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              var books = snapshot.data!;
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  var book = books[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        AppNavigator.push(context, BookDetailScreen(book: book));
                      },
                      child: Card(
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text("Author: ${book.author}"),
                              if (book.description != null) Text("Description: ${book.description}"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Center(child: Text('No books available'));
          },
        )


    );
  }
}
