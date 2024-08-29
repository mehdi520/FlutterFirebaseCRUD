// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      successResponse:
          _$nullableGenericFromJson(json['successResponse'], fromJsonT),
      errorResponse: json['errorResponse'] == null
          ? null
          : ErrorResponse.fromJson(
              json['errorResponse'] as Map<String, dynamic>),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'successResponse':
          _$nullableGenericToJson(instance.successResponse, toJsonT),
      'errorResponse': instance.errorResponse,
      'success': instance.success,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
