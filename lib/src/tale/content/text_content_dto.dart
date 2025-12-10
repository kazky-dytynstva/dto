import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_content_dto.g.dart';

@JsonSerializable()
class TextContentDto extends Equatable {
  const TextContentDto({
    required this.paragraphs,
    required this.minReadingTime,
    required this.maxReadingTime,
  }) : assert(paragraphs.length > 0, 'Paragraphs should not be empty'),
       assert(minReadingTime > 0, 'Min reading time should be positive'),
       assert(
         maxReadingTime > minReadingTime,
         'Max reading time should be greater than min reading time',
       );

  /// Represents a tale text.
  @_ParagraphConverter()
  final List<Paragraph> paragraphs;

  /// Represents a minimum reading time in minutes.
  final int minReadingTime;

  /// Represents a maximum reading time in minutes.
  final int maxReadingTime;

  factory TextContentDto.fromJson(Map<String, dynamic> json) =>
      _$TextContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TextContentDtoToJson(this);

  @override
  List<Object?> get props => [paragraphs, minReadingTime, maxReadingTime];

  TextContentDto copyWith({
    List<Paragraph>? paragraphs,
    int? minReadingTime,
    int? maxReadingTime,
  }) {
    return TextContentDto(
      paragraphs: paragraphs ?? this.paragraphs,
      minReadingTime: minReadingTime ?? this.minReadingTime,
      maxReadingTime: maxReadingTime ?? this.maxReadingTime,
    );
  }
}

sealed class Paragraph extends Equatable {
  const Paragraph();

  const factory Paragraph.text({required String text}) = TextParagraph._;
  const factory Paragraph.image({required int imageIndex}) = ImageParagraph._;

  T when<T>({
    required T Function(String text) text,
    required T Function(int imageIndex) image,
  }) {
    final self = this;
    return switch (self) {
      TextParagraph() => text(self.text),
      ImageParagraph() => image(self.imageIndex),
    };
  }
}

class TextParagraph extends Paragraph {
  const TextParagraph._({required this.text}) : super();

  final String text;

  @override
  List<Object?> get props => [text];
}

class ImageParagraph extends Paragraph {
  const ImageParagraph._({required this.imageIndex}) : super();

  final int imageIndex;

  @override
  List<Object?> get props => [imageIndex];
}

final _imagePattern = RegExp(r'^\[(\d+)\]$');

class _ParagraphConverter implements JsonConverter<Paragraph, String> {
  const _ParagraphConverter();

  @override
  Paragraph fromJson(String json) {
    final match = _imagePattern.firstMatch(json);
    if (match != null) {
      final imageIndex = int.parse(match.group(1)!);
      return Paragraph.image(imageIndex: imageIndex);
    }

    return Paragraph.text(text: json);
  }

  @override
  String toJson(Paragraph paragraph) => paragraph.when(
    text: (text) => text,
    image: (imageIndex) => '[$imageIndex]',
  );
}
