import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_content_dto.g.dart';

@JsonSerializable()
class AudioContentDto extends Equatable {
  AudioContentDto({required this.fileSize, required this.duration})
    : assert(fileSize > 0, 'File size should be positive'),
      assert(duration > Duration.zero, 'Duration should be positive');

  /// Represents a tale text.
  final int fileSize;

  /// Represents audio duration
  final Duration duration;

  factory AudioContentDto.fromJson(Map<String, dynamic> json) =>
      _$AudioContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AudioContentDtoToJson(this);

  @override
  List<Object?> get props => [fileSize, duration];

  AudioContentDto copyWith({int? fileSize, Duration? duration}) {
    return AudioContentDto(
      fileSize: fileSize ?? this.fileSize,
      duration: duration ?? this.duration,
    );
  }
}
