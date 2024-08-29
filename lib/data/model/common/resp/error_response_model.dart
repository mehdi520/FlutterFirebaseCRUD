import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response_model.g.dart';

@JsonSerializable()
class ErrorResponse extends Equatable {
  final String message;
  final int? code;

  ErrorResponse({required this.message, this.code});

  // Factory constructor to create an instance from JSON
  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @override
  List<Object?> get props => [message, code];
}
