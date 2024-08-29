import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';
import 'package:my_books_app/core/common_widgets/common_button/primary_button.dart';
import 'package:my_books_app/core/common_widgets/text/gradient_text.dart';
import 'package:my_books_app/core/common_widgets/text_fields/primary_text_form_field.dart';
import 'package:my_books_app/core/extention/flush_bar_extension.dart';
import 'package:my_books_app/core/loader/overlay_service.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/model/user/user_model.dart';
import 'package:my_books_app/data/repository/user/user_repository_impl.dart';
import 'package:my_books_app/domain/user/user_repository.dart';


class SignupScreen extends StatelessWidget {
  final UserRepository userRepository = UserRepositoryImpl();
   SignupScreen({super.key});
   final _formKey = GlobalKey<FormState>();
   TextEditingController _nameCtrl = TextEditingController();
   TextEditingController _emailController = TextEditingController();
   TextEditingController _phoneCtrl = TextEditingController();
   TextEditingController _passController = TextEditingController();
  final OverlayService _overlayService = OverlayService();


  void _signup(BuildContext context) async {
    _overlayService.showLoadingOverlay(context);

    UserModel req = UserModel(name: _nameCtrl.text,
        email: _emailController.text,
        phone: _phoneCtrl.text,password: _passController.text, id: '0');

     BaseResponse resp = await userRepository.register(req);
    _overlayService.hideLoadingOverlay();

    if(resp.success)
       {
               context.flushBarSuccessMessage(message: "Signup successfully.");
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


    return Scaffold(
        body:   Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.15,
                  ),
                  Container(
                      width: MediaQuery.sizeOf(context).width,
                      child: Center(
                        child: GradientText(
                            text: "Book App",
                          style:  TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          )

                        ),
                      )),
                  SizedBox(                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  PrimaryTextFormField(
                      keyboardType: TextInputType.name,
                      imeAction: TextInputAction.next,
                      ctrl: _nameCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required.';
                        }
                      },
                      hintText: 'Name'),
                  SizedBox(height: 15),
                  PrimaryTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      imeAction: TextInputAction.next,

                      ctrl: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required.';
                        }
                      },
                      hintText: 'Email'),

                  SizedBox(height: 15),
                  PrimaryTextFormField(
                      keyboardType: TextInputType.phone,
                      imeAction: TextInputAction.next,

                      ctrl: _phoneCtrl,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone is required.';
                        }
                      },
                      hintText: 'Phone'),
                  SizedBox(
                    height: 15,
                  ),
                  PrimaryTextFormField(
                      keyboardType: TextInputType.name,
                      imeAction: TextInputAction.done,
                      isSecureTextField: true,
                      ctrl: _passController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required.';
                        }
                      },
                      hintText: 'Password'),
              
                  SizedBox(
                    height: 30,
                  ),
                 PrimaryButton(
                      text: "Register",
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
                  _dont_have_Acc(context)
                ],
              ),
            ),
          ),
        )
    );
  }


  Widget _dont_have_Acc(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Already have an Account?',
              style: TextStyle(color: AppColors.secondary)),
        ),
        Center(
          child: Container(
            height: 2,
            width: 190,
            color: AppColors.primary,
          ),
        )
      ],
    );
  }
}
