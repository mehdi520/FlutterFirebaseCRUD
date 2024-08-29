import 'package:flutter/material.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';
import 'package:my_books_app/core/common_widgets/common_button/primary_button.dart';
import 'package:my_books_app/core/common_widgets/text_fields/primary_text_form_field.dart';
import 'package:my_books_app/core/extention/flush_bar_extension.dart';
import 'package:my_books_app/core/loader/overlay_service.dart';
import 'package:my_books_app/data/model/book/book_model.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/repository/book/book_repository_impl.dart';
import 'package:my_books_app/domain/book/book_repository.dart';

class UpdateBookScreen extends StatelessWidget {
  BookModel book;

  UpdateBookScreen({super.key, required this.book});
  final OverlayService _overlayService = OverlayService();
  final BookRepository bookRepository = BookRepositoryImpl();
  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _desCtrl = TextEditingController();
  TextEditingController _authorCtrl = TextEditingController();
  TextEditingController _isbnCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  void _signup(BuildContext context) async {
    _overlayService.showLoadingOverlay(context);
    BookModel req = BookModel(
        title: _titleCtrl.text,
        author: _authorCtrl.text,
        description: _desCtrl.text,
        id: book.id,
        isbn: _isbnCtrl.text,
        price: double.parse(_priceCtrl.text)
    );

    BaseResponse resp = await bookRepository.updateBook(req);
    _overlayService.hideLoadingOverlay();

    if(resp.success)
    {
      context.flushBarSuccessMessage(message: "Book updated successfully.");
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(context);
    }
    else
    {
      context.flushBarErrorMessage(message: resp.errorResponse!.message.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    _titleCtrl.text = book.title;
    _desCtrl.text = book.description;
    _authorCtrl.text = book.author;
    _priceCtrl.text = book.price.toString();
    _isbnCtrl.text = book.isbn;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: AppColors.white
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text('Book Update',style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold),),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text('Please update the required changes below.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.normal
                  ),
                ),
                SizedBox(height: 15),
                PrimaryTextFormField(
                    keyboardType: TextInputType.text,
                    imeAction: TextInputAction.next,
                    ctrl: _titleCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Title is required.';
                      }
                    },
                    hintText: 'Title'),
                SizedBox(height: 15),
                PrimaryTextFormField(
                    keyboardType: TextInputType.text,
                    imeAction: TextInputAction.next,
                    ctrl: _desCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description is required.';
                      }
                    },
                    hintText: 'Description'),
                SizedBox(height: 15),
                PrimaryTextFormField(
                    keyboardType: TextInputType.text,
                    imeAction: TextInputAction.next,
                    ctrl: _authorCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Author is required.';
                      }
                    },
                    hintText: 'Author'),

                SizedBox(height: 15),
                PrimaryTextFormField(
                    keyboardType: TextInputType.text,
                    imeAction: TextInputAction.next,
                    ctrl: _isbnCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ISBN is required.';
                      }
                    },
                    hintText: 'ISBN'),
                SizedBox(height: 15),
                PrimaryTextFormField(
                    keyboardType: TextInputType.numberWithOptions(signed: false,decimal: true),
                    imeAction: TextInputAction.done,
                    ctrl: _priceCtrl,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Price is required.';
                      }
                    },
                    hintText: 'Price'),
                SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  text: "Update",
                  onTap: () {

                    if (_formKey.currentState?.validate() ?? false) {
                      _signup(context);
                    }
                    else
                    {
                      context.flushBarErrorMessage(message: 'Please provide all required fields.');
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

