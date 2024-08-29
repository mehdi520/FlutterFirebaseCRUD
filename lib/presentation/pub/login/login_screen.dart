import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';
import 'package:my_books_app/core/common_widgets/common_button/primary_button.dart';
import 'package:my_books_app/core/common_widgets/text/gradient_text.dart';
import 'package:my_books_app/core/common_widgets/text_fields/primary_text_form_field.dart';
import 'package:my_books_app/core/extention/flush_bar_extension.dart';
import 'package:my_books_app/core/loader/overlay_service.dart';
import 'package:my_books_app/core/navigator/app_navigator.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/model/user/user_model.dart';
import 'package:my_books_app/data/repository/user/user_repository_impl.dart';
import 'package:my_books_app/domain/user/user_repository.dart';
import 'package:my_books_app/presentation/home/home_screen.dart';
import 'package:my_books_app/presentation/pub/signup/signup_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final UserRepository userRepository = UserRepositoryImpl();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final OverlayService _overlayService = OverlayService();

  void _signIn(BuildContext context) async {
    _overlayService.showLoadingOverlay(context);

    UserModel req = UserModel(name: '',
        email: _emailController.text,
        phone: '',password: _passController.text, id: '0');

    BaseResponse resp = await userRepository.login(req);
    _overlayService.hideLoadingOverlay();

    if(resp.success)
    {
      context.flushBarSuccessMessage(message: "Login successfully.");
      await Future.delayed(const Duration(seconds: 2));
      AppNavigator.pushReplacement(context, HomeScreen());
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
                    height: MediaQuery.sizeOf(context).height * 0.2,
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
                  SizedBox(                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  PrimaryTextFormField(
                      keyboardType: TextInputType.name,
                      ctrl: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required.';
                        }
                      },
                      hintText: 'Email'),
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
                    height: 50,
                  ),
                  PrimaryButton(
                    text: "Sign In",
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _signIn(context);
                      }
                      else {
                        // context.flushBarErrorMessage(
                        //     message: 'Please provide all required fields.');
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _forgetPassword(context),
                  _dont_have_Acc(context)
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget _forgetPassword(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
           // AppNavigator.push(context, ForgotPassScreen());
          },
          child: Text('Forget Password',
              style: TextStyle(color: AppColors.secondary)),
        ),
        Center(
          child: Container(
            height: 2,
            width: 150,
            color: AppColors.primary,
          ),
        )
      ],
    );
  }

  Widget _dont_have_Acc(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            AppNavigator.push(context, SignupScreen());
          },
          child: Text('Do not have an Account?',
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
