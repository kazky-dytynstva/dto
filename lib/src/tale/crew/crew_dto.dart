import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crew_dto.g.dart';

@JsonSerializable()
class CrewDto extends Equatable {
  CrewDto({
    this.authors,
    this.readers,
    this.musicians,
    this.translators,
    this.graphics,
  }) : assert(
         (authors?.isNotEmpty == true) ||
             (readers?.isNotEmpty == true) ||
             (musicians?.isNotEmpty == true) ||
             (translators?.isNotEmpty == true) ||
             (graphics?.isNotEmpty == true),
       );

  final List<int>? authors;
  final List<int>? readers;
  final List<int>? musicians;
  final List<int>? translators;
  final List<int>? graphics;

  late final Set<int> allMembers = {
    ...?authors,
    ...?readers,
    ...?musicians,
    ...?translators,
    ...?graphics,
  };

  factory CrewDto.fromJson(Map<String, dynamic> json) =>
      _$CrewDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CrewDtoToJson(this);

  @override
  List<Object?> get props => [
    authors,
    readers,
    musicians,
    translators,
    graphics,
  ];

  CrewDto copyWith({
    List<int>? authors,
    bool clearAuthors = false,
    List<int>? readers,
    bool clearReaders = false,
    List<int>? musicians,
    bool clearMusicians = false,
    List<int>? translators,
    bool clearTranslators = false,
    List<int>? graphics,
    bool clearGraphics = false,
  }) {
    return CrewDto(
      authors: clearAuthors ? null : authors ?? this.authors,
      readers: clearReaders ? null : readers ?? this.readers,
      musicians: clearMusicians ? null : musicians ?? this.musicians,
      translators: clearTranslators ? null : translators ?? this.translators,
      graphics: clearGraphics ? null : graphics ?? this.graphics,
    );
  }

  bool containsMember({required int personId}) {
    return allMembers.contains(personId);
  }
}
