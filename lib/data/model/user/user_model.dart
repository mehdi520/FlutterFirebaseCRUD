import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String name;
   String id;
  final String email;
  final String password;
  final String phone;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.password,
    required this.phone,
  });

  // Factory constructor for creating a new `UserModel` instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // Method to convert a `UserModel` instance to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [name, id, email, password, phone];
}
