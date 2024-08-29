// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_list_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookListRespModel _$GetBookListRespModelFromJson(
        Map<String, dynamic> json) =>
    GetBookListRespModel(
      books: (json['books'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBookListRespModelToJson(
        GetBookListRespModel instance) =>
    <String, dynamic>{
      'books': instance.books,
    };
