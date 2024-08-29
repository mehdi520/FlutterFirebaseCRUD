import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_books_app/core/app_colors/app_color.dart';
import 'package:my_books_app/core/common_widgets/common_button/primary_button.dart';
import 'package:my_books_app/core/extention/flush_bar_extension.dart';
import 'package:my_books_app/core/navigator/app_navigator.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/repository/user/user_repository_impl.dart';
import 'package:my_books_app/domain/user/user_repository.dart';
import 'package:my_books_app/presentation/add_book/add_book_screen.dart';
import 'package:my_books_app/presentation/book_list/book_list_screen.dart';
import 'package:my_books_app/presentation/profile/profile_screen.dart';
import 'package:my_books_app/presentation/pub/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  final UserRepository userRepository = UserRepositoryImpl();

   void logout(BuildContext context)  async{
     BaseResponse resp = await userRepository.logout();
     if(resp.success)
       {
         AppNavigator.pushReplacement(context, LoginScreen());

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
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        iconTheme: IconThemeData(
            color: AppColors.white
        ),
        title: Text('Book App',style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(onPressed: (){
            AppNavigator.push(context, ProfileScreen());
          }, icon: Icon(Icons.account_circle_outlined,color: AppColors.white,)),
          SizedBox(width: 15,)
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Text('Welcome to Book App,Please click below button to list the available books',
              textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondary,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height: 50,),

            PrimaryButton(text: 'Book List', onTap: (){
              AppNavigator.push(context, BookListScreen());
            }),
            SizedBox(height: 20,),
            PrimaryButton(text: 'Add book', onTap: (){
              AppNavigator.push(context, AddBookScreen());
            }),
            SizedBox(height: 20,),

            PrimaryButton(text: 'Sign Out', onTap: (){
             logout(context);
            }),
          ],
        ),
      ),
    );
  }
}


