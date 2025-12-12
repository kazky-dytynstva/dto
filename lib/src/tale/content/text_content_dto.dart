import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_content_dto.g.dart';

@JsonSerializable()
class TextContentDto extends Equatable {
  TextContentDto({
    required this.items,
    required this.minReadingTime,
    required this.maxReadingTime,
  }) : assert(items.isNotEmpty, 'Items should not be empty'),
       assert(
         items.first is ContentItemImage &&
             (items.first as ContentItemImage).imageIndex == 0,
         'First item should be an image with index 0',
       ),
       assert(minReadingTime > 0, 'Min reading time should be positive'),
       assert(
         maxReadingTime > minReadingTime,
         'Max reading time should be greater than min reading time',
       );

  /// Represents a tale content items (text and images).
  @_ContentItemConverter()
  final List<ContentItem> items;

  /// Represents a minimum reading time in minutes.
  final int minReadingTime;

  /// Represents a maximum reading time in minutes.
  final int maxReadingTime;

  factory TextContentDto.fromJson(Map<String, dynamic> json) =>
      _$TextContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TextContentDtoToJson(this);

  @override
  List<Object?> get props => [items, minReadingTime, maxReadingTime];

  TextContentDto copyWith({
    List<ContentItem>? items,
    int? minReadingTime,
    int? maxReadingTime,
  }) {
    return TextContentDto(
      items: items ?? this.items,
      minReadingTime: minReadingTime ?? this.minReadingTime,
      maxReadingTime: maxReadingTime ?? this.maxReadingTime,
    );
  }
}

sealed class ContentItem extends Equatable {
  const ContentItem();

  const factory ContentItem.text({required String text}) = ContentItemText._;
  const factory ContentItem.image({required int imageIndex}) =
      ContentItemImage._;

  T when<T>({
    required T Function(String text) text,
    required T Function(int imageIndex) image,
  }) {
    final self = this;
    return switch (self) {
      ContentItemText() => text(self.text),
      ContentItemImage() => image(self.imageIndex),
    };
  }
}

class ContentItemText extends ContentItem {
  const ContentItemText._({required this.text}) : super();

  final String text;

  @override
  List<Object?> get props => [text];
}

class ContentItemImage extends ContentItem {
  const ContentItemImage._({required this.imageIndex}) : super();

  final int imageIndex;

  @override
  List<Object?> get props => [imageIndex];
}

final _imagePattern = RegExp(r'^\[(\d+)\]$');

class _ContentItemConverter implements JsonConverter<ContentItem, String> {
  const _ContentItemConverter();

  @override
  ContentItem fromJson(String json) {
    final match = _imagePattern.firstMatch(json);
    if (match != null) {
      final imageIndex = int.parse(match.group(1)!);
      return ContentItem.image(imageIndex: imageIndex);
    }

    return ContentItem.text(text: json);
  }

  @override
  String toJson(ContentItem contentItem) => contentItem.when(
    text: (text) => text,
    image: (imageIndex) => '[$imageIndex]',
  );
}
