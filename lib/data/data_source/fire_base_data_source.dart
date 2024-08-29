import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_books_app/data/model/book/book_model.dart';
import 'package:my_books_app/data/model/book/get_book_list_resp_model.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/model/common/resp/error_response_model.dart';
import 'package:my_books_app/data/model/user/user_model.dart';

class FireBaseDataSource {
  FireBaseDataSource._privateConstructor();
  static final FireBaseDataSource _instance = FireBaseDataSource._privateConstructor();
  factory FireBaseDataSource() {
    return _instance;
  }
  static final FirebaseAuth firebaseAuth  = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static CollectionReference userCollectionReference = firebaseFirestore.collection("user");
  static CollectionReference booksCollectionReference = firebaseFirestore.collection("books");

  static Future<BaseResponse> register(UserModel user) async {
    try{
      UserCredential userCredential =  await firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: user.password!);

      var userDocRef = userCollectionReference.doc(userCredential.user!.uid);
      user.id = userCredential.user!.uid;
      var res = await userDocRef.set(user.toJson());
      return BaseResponse(success: true);
    }
    catch (ex)
    {
      return BaseResponse(success: false,errorResponse: ErrorResponse(message: ex.toString(),code: 500));
    }
  }
  static Future<BaseResponse> login(UserModel user) async {
    try{
      UserCredential userCredential =  await firebaseAuth.signInWithEmailAndPassword(email: user.email, password: user.password!);

      if(userCredential != null && userCredential.user != null)
        {
          return BaseResponse(success: true);
        }
      else
        {
          return BaseResponse(success: false,errorResponse: ErrorResponse(message: 'Invalid email or password',code: 500));

        }
    }
    catch (ex)
    {
      return BaseResponse(success: false,errorResponse: ErrorResponse(message: ex.toString(),code: 500));
    }
  }


  static Future<BaseResponse> getProfile() async {
    try{

      var userId = firebaseAuth.currentUser?.uid;
      print(userId);
      if(userId == null)
        {
          return BaseResponse(success: false,errorResponse: ErrorResponse(message: 'Your session expired.Please login again to continue.',code: 500));

        }
      else
        {
          DocumentSnapshot<Object?> documentSnapshot = await userCollectionReference.doc(userId).get();
          print(documentSnapshot.toString());
          var user = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
          return BaseResponse(success: true,successResponse: user);

        }
    }
    catch (ex)
    {
      print(ex.toString());
      return BaseResponse(success: false,errorResponse: ErrorResponse(message: ex.toString(),code: 500));
    }
  }
  static Future<BaseResponse> logout() async {
    try{
      var res = firebaseAuth.signOut();
      return BaseResponse(success: true);
    }
    catch (ex)
    {
      return BaseResponse(success: false,errorResponse: ErrorResponse(message: ex.toString(),code: 500));
    }
  }

  static Future<BaseResponse> isLoggedIn() async {
    try{

      var userId = await firebaseAuth.currentUser?.uid;
      if(userId == null)
      {
        return BaseResponse(success: false,errorResponse: ErrorResponse(message: 'Your session expired.Please login again to continue.',code: 500));

      }
      else
      {

        return BaseResponse(success: true);

      }
    }
    catch (ex)
    {
      return BaseResponse(success: false,errorResponse: ErrorResponse(message: ex.toString(),code: 500));
    }
  }

  static Future<BaseResponse> updateProfile(UserModel user) async {
    try {
      if (user.id != null) {
        var userref = userCollectionReference.doc(user.id);
        await userref.update(user.toJson());
        return BaseResponse(success: true);
      } else {
        return BaseResponse(success: false, errorResponse: ErrorResponse(message: "User ID is null", code: 400));
      }
    } catch (ex) {
      return BaseResponse(success: false, errorResponse: ErrorResponse(message: ex.toString(), code: 500));
    }
  }

//book start
  static Future<BaseResponse> createBook(BookModel book) async {
    try {
      var bookDocRef = booksCollectionReference.doc();
      book.id = bookDocRef.id;
      await bookDocRef.set(book.toJson());
      return BaseResponse(success: true);
    } catch (ex) {
      return BaseResponse(success: false, errorResponse: ErrorResponse(message: ex.toString(), code: 500));
    }
  }

  static Future<BaseResponse> getBookById(String id) async {
    try {
      var docSnapshot = await booksCollectionReference.doc(id).get();
      if (docSnapshot.exists) {
        BookModel book = BookModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
        return BaseResponse(success: true);
      } else {
        return BaseResponse(success: false, errorResponse: ErrorResponse(message: "Book not found", code: 404));
      }
    } catch (ex) {
      return BaseResponse(success: false, errorResponse: ErrorResponse(message: ex.toString(), code: 500));
    }
  }

  static Future<BaseResponse> updateBook(BookModel book) async {
    try {
      if (book.id != null) {
        var bookDocRef = booksCollectionReference.doc(book.id);
        await bookDocRef.update(book.toJson());
        return BaseResponse(success: true);
      } else {
        return BaseResponse(success: false, errorResponse: ErrorResponse(message: "Book ID is null", code: 400));
      }
    } catch (ex) {
      return BaseResponse(success: false, errorResponse: ErrorResponse(message: ex.toString(), code: 500));
    }
  }

  static Future<BaseResponse> deleteBook(String id) async {
    try {
      var bookDocRef = booksCollectionReference.doc(id);
      await bookDocRef.delete();
      return BaseResponse(success: true);
    } catch (ex) {
      return BaseResponse(success: false, errorResponse: ErrorResponse(message: ex.toString(), code: 500));
    }
  }

  static Future<BaseResponse> getBooks() async {
    try {
      QuerySnapshot querySnapshot = await booksCollectionReference.get();
      List<BookModel> books = querySnapshot.docs.map((doc) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      print(books.length.toString());
      return BaseResponse(success: true, successResponse: GetBookListRespModel(books: books));
    } catch (ex) {
      return BaseResponse(success: false, errorResponse: ErrorResponse(message: ex.toString(), code: 500));
    }
  }

  static Stream<List<BookModel>> getBooksStream() {
    return booksCollectionReference
        .snapshots()
        .map((snapshot){
      return    snapshot.docs.map((doc) {
        return BookModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

    });
  }


}