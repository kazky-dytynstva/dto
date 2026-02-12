import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_config_dto.g.dart';

@JsonSerializable()
class AdminConfigDto extends Equatable {
  AdminConfigDto({bool? isHidden, bool? isReviewed, String? comment})
    : isHidden = isHidden == true ? true : null,
      isReviewed = isReviewed == true ? true : null,
      comment = comment == null || comment.isEmpty ? null : comment;

  final bool? isHidden;
  final bool? isReviewed;
  final String? comment;

  factory AdminConfigDto.fromJson(Map<String, dynamic> json) =>
      _$AdminConfigDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdminConfigDtoToJson(this);

  bool get isEmpty => isHidden == null && isReviewed == null && comment == null;

  @override
  List<Object?> get props => [isHidden, isReviewed, comment];

  AdminConfigDto copyWith({
    bool? isHidden,
    bool? isReviewed,
    String? comment,
    bool resetIsHidden = false,
    bool resetIsREviewed = false,
    bool resetComment = false,
  }) {
    return AdminConfigDto(
      isHidden: resetIsHidden ? null : isHidden,
      isReviewed: resetIsREviewed ? null : isReviewed,
      comment: resetComment ? null : comment,
    );
  }
}
