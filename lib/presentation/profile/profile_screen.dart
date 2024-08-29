import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';
import 'package:my_books_app/core/common_widgets/common_button/primary_button.dart';
import 'package:my_books_app/core/common_widgets/text_fields/primary_text_form_field.dart';
import 'package:my_books_app/core/extention/flush_bar_extension.dart';
import 'package:my_books_app/core/loader/overlay_service.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/model/user/user_model.dart';
import 'package:my_books_app/data/repository/user/user_repository_impl.dart';
import 'package:my_books_app/domain/user/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  final OverlayService _overlayService = OverlayService();
  final UserRepository userRepository = UserRepositoryImpl();

  ProfileScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneCtrl = TextEditingController();
  // TextEditingController _passController = TextEditingController();

  void _updateProfile(BuildContext context,String email,String pass,String id) async {
    _overlayService.showLoadingOverlay(context);

    UserModel req = UserModel(name: _nameCtrl.text,
        email: email,
        phone: _phoneCtrl.text,password: pass, id: id);

    BaseResponse resp = await userRepository.updateProfile(req);
    _overlayService.hideLoadingOverlay();

    if(resp.success)
    {
      context.flushBarSuccessMessage(message: "Profile updated successfully.");
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'Profile Details',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: userRepository.getProfile(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var resp = snapshot.data as BaseResponse;
            if(resp.success) {
              var profile = resp.successResponse as UserModel;
              _nameCtrl.text = profile.name ?? '';
              _emailController.text = profile.email ?? '';
              _phoneCtrl.text = profile.phone ?? '';

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery
                              .sizeOf(context)
                              .height * 0.05,
                        ),
                        PrimaryTextFormField(
                          keyboardType: TextInputType.name,
                          imeAction: TextInputAction.next,
                          ctrl: _nameCtrl,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is required.';
                            }
                            return null;
                          },
                          hintText: 'Name',
                        ),
                        SizedBox(height: 15),
                        PrimaryTextFormField(
                          keyboardType: TextInputType.none,
                          imeAction: TextInputAction.next,
                          ctrl: _emailController,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required.';
                            }
                            return null;
                          },
                          hintText: 'Email',
                        ),
                        SizedBox(height: 15),
                        PrimaryTextFormField(
                          keyboardType: TextInputType.phone,
                          imeAction: TextInputAction.next,
                          ctrl: _phoneCtrl,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone is required.';
                            }
                            return null;
                          },
                          hintText: 'Phone',
                        ),

                        SizedBox(height: 30),
                        PrimaryButton(
                          text: "Update profile",
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                               _updateProfile(context,profile.email,profile.password,profile.id);
                            } else {
                              context.flushBarErrorMessage(
                                  message: 'Please provide all required fields.');
                            }
                          },
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              );
            }
            else
              {
                return Center(child: Text('No profile data available'));
              }
          } else {
            return Center(child: Text('No profile data available'));
          }
        },
      ),

    );
  }
}
