import 'package:my_books_app/data/data_source/fire_base_data_source.dart';
import 'package:my_books_app/data/model/book/book_model.dart';
import 'package:my_books_app/domain/book/book_repository.dart';

import '../../model/common/resp/base_response_model.dart';

class BookRepositoryImpl extends BookRepository{
  @override
  Future<BaseResponse> createBook(BookModel book) {
    return FireBaseDataSource.createBook(book);
  }

  @override
  Future<BaseResponse> deleteBook(String id) {
    return FireBaseDataSource.deleteBook(id);
  }

  @override
  Future<BaseResponse> getBookById(String id) {
    return FireBaseDataSource.getBookById(id);
  }

  @override
  Future<BaseResponse> getBooks() {
    return FireBaseDataSource.getBooks();
  }

  @override
  Future<BaseResponse> updateBook(BookModel book) {
    return FireBaseDataSource.updateBook(book);
  }

  @override
  Stream<List<BookModel>> getBooksStream() {
   return FireBaseDataSource.getBooksStream();
  }


}