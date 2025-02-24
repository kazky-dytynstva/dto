import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_content.g.dart';

@JsonSerializable()
class TextContentDto extends Equatable {
  /// Represents a tale text.
  ///
  /// If list item is a number, it means that this is an image reference.
  /// In that case, the number represents the image index for this tale.
  final List<String> paragraphs;

  /// Represents a minimum reading time in minutes.
  final int minReadingTime;

  /// Represents a maximum reading time in minutes.
  final int maxReadingTime;

  const TextContentDto({
    required this.paragraphs,
    required this.minReadingTime,
    required this.maxReadingTime,
  })  : assert(
          paragraphs.length > 0,
          'Paragraphs should not be empty',
        ),
        assert(
          minReadingTime > 0,
          'Min reading time should be positive',
        ),
        assert(
          maxReadingTime > minReadingTime,
          'Max reading time should be greater than min reading time',
        );

  factory TextContentDto.fromJson(Map<String, dynamic> json) =>
      _$TextContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TextContentDtoToJson(this);

  @override
  List<Object?> get props => [
        paragraphs,
        minReadingTime,
        maxReadingTime,
      ];
}
