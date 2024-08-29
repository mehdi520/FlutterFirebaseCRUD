import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel extends Equatable {
  final String title;
  final String description;

  final String author;
       String id;
  final String isbn;
  final double price;

  BookModel({
    required this.title,
    required this.author,
    required this.description,

    required this.id,
    required this.isbn,
    required this.price,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);

  @override
  List<Object?> get props => [title, author, id, isbn, description, price];
}
