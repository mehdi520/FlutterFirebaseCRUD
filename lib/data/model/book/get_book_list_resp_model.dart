import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_books_app/data/model/book/book_model.dart';

part 'get_book_list_resp_model.g.dart';
@JsonSerializable()
class GetBookListRespModel extends Equatable{
   List<BookModel> books;
   GetBookListRespModel({
     required this.books
});

   factory GetBookListRespModel.fromJson(Map<String, dynamic> json) => _$GetBookListRespModelFromJson(json);

   Map<String, dynamic> toJson() => _$GetBookListRespModelToJson(this);

   @override
   List<Object?> get props => [books];
}

