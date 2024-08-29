// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      id: json['id'] as String,
      isbn: json['isbn'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'id': instance.id,
      'isbn': instance.isbn,
      'price': instance.price,
    };
