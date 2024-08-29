import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/model/user/user_model.dart';

abstract class UserRepository{
  Future<BaseResponse> register(UserModel user);
  Future<BaseResponse> login(UserModel user);
  Future<BaseResponse> getProfile();
  Future<BaseResponse> updateProfile(UserModel user) ;
  Future<BaseResponse> isLoggedIn();
  Future<BaseResponse> logout();
}