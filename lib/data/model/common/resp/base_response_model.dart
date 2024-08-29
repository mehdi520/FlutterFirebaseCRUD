import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_books_app/data/model/common/resp/error_response_model.dart';


part 'base_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> extends Equatable {
  final T? successResponse;
  final ErrorResponse? errorResponse;
  final bool success;

  BaseResponse({
    this.successResponse,
    this.errorResponse,
    required this.success,
  });

  // Factory constructor that now expects a T Function(Object?) instead of Map<String, dynamic>
  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  // Method to convert the instance to JSON, using Object? instead of Map<String, dynamic>
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) => _$BaseResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [successResponse, errorResponse, success];
}
