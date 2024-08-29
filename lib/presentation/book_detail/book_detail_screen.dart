import 'package:flutter/material.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';
import 'package:my_books_app/core/common_widgets/common_button/primary_button.dart';
import 'package:my_books_app/core/extention/flush_bar_extension.dart';
import 'package:my_books_app/core/loader/overlay_service.dart';
import 'package:my_books_app/core/navigator/app_navigator.dart';
import 'package:my_books_app/data/model/book/book_model.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/repository/book/book_repository_impl.dart';
import 'package:my_books_app/domain/book/book_repository.dart';
import 'package:my_books_app/presentation/update_book/update_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final OverlayService _overlayService = OverlayService();
  final BookRepository bookRepository = BookRepositoryImpl();
  BookModel book;

  BookDetailScreen({super.key, required this.book});


  void deleteBook(BuildContext context) async {
    _overlayService.showLoadingOverlay(context);

    BaseResponse resp = await bookRepository.deleteBook(book.id);
    _overlayService.hideLoadingOverlay();

    if(resp.success)
    {
      context.flushBarSuccessMessage(message: "Book deleted successfully.");
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(context);
    }
    else
    {
      context.flushBarErrorMessage(message: resp.errorResponse!.message.toString());
    }
  }

  Future<void> showDeleteConfirmationDialog(
      BuildContext context, VoidCallback onConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'Book Detail',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Row(
              children: [
                Container(
                    width: 150,
                    child: Text(
                      'Book Title :',
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  book.title,
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 150,
                    child: Text(
                      'Description :',
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Expanded(
                  child: Text(
                    maxLines: null, 
                    overflow: TextOverflow.visible,
                    book.description,

                    style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 150,
                    child: Text(
                      'Author :',
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  book.author,
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 150,
                    child: Text(
                      'ISBN :',
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  book.isbn,
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 150,
                    child: Text(
                      'Price :',
                      style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  book.price.toString(),
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        // Use the provided color
                        minimumSize:
                            Size(90, 40), // Set minimum size for smaller button
                      ),
                      onPressed: () {
                        AppNavigator.pushReplacement(
                            context, UpdateBookScreen(book: book));
                      },
                      child:
                          Text('Edit', style: TextStyle(color: Colors.white)),
                    )),
                Container(
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        // Use the provided color
                        minimumSize:
                            Size(90, 40), // Set minimum size for smaller button
                      ),
                      onPressed: () {
                        showDeleteConfirmationDialog(context, () {
                          deleteBook(context);
                        });
                      },
                      child:
                          Text('Delete', style: TextStyle(color: Colors.white)),
                    )),
              ],
            ),
          ])),
    );
  }
}
