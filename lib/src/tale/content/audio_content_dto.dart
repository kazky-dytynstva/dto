import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_content_dto.g.dart';

@JsonSerializable()
class AudioContentDto extends Equatable {
  /// Represents a tale text.
  final int fileSize;

  /// Represents audio duration in miliseconds.
  final int duration;

  const AudioContentDto({
    required this.fileSize,
    required this.duration,
  })  : assert(
          fileSize > 0,
          'File size should be positive',
        ),
        assert(
          duration > 0,
          'Duration should be positive',
        );

  factory AudioContentDto.fromJson(Map<String, dynamic> json) =>
      _$AudioContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AudioContentDtoToJson(this);

  @override
  List<Object?> get props => [
        fileSize,
        duration,
      ];
}
