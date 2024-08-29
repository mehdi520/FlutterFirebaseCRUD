import 'package:my_books_app/data/model/book/book_model.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';

abstract class BookRepository{
  Future<BaseResponse> createBook(BookModel book);
  Future<BaseResponse> getBookById(String id) ;
  Future<BaseResponse> updateBook(BookModel book) ;
  Future<BaseResponse> deleteBook(String id) ;
  Future<BaseResponse> getBooks();
  Stream<List<BookModel>> getBooksStream();
}