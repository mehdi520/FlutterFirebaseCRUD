import 'package:my_books_app/data/data_source/fire_base_data_source.dart';
import 'package:my_books_app/data/model/common/resp/base_response_model.dart';
import 'package:my_books_app/data/model/user/user_model.dart';
import 'package:my_books_app/domain/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  @override
  Future<BaseResponse> getProfile() {
    return FireBaseDataSource.getProfile();
  }

  @override
  Future<BaseResponse> login(UserModel user) {
    return FireBaseDataSource.login(user);
  }

  @override
  Future<BaseResponse> logout() {
    return FireBaseDataSource.logout();
  }

  @override
  Future<BaseResponse> register(UserModel user) {
    return FireBaseDataSource.register(user);
  }

  @override
  Future<BaseResponse> isLoggedIn()  {
    return  FireBaseDataSource.isLoggedIn();

  }

  @override
  Future<BaseResponse> updateProfile(UserModel user) {
    return  FireBaseDataSource.updateProfile(user);

  }
  
}