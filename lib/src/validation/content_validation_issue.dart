import 'package:equatable/equatable.dart';

enum ContentValidationCode {
  requiredValue,
  invalidId,
  lengthOutOfRange,
  updateNotAfterCreate,
  emptyCollection,
  duplicateValue,
  missingMedia,
  invalidMedia,
  invalidThumbnailFormat,
  missingContent,
  tagContentMismatch,
  invalidImageSequence,
  missingImageReference,
  adjacentImages,
  invalidReadingTime,
  invalidAudioMetadata,
  audioSizeMismatch,
  unexpectedMedia,
  invalidCrewRole,
  missingReadyPerson,
}

class ContentValidationIssue extends Equatable {
  const ContentValidationIssue(this.code, this.field, {this.relatedId});

  final ContentValidationCode code;
  final String field;
  final int? relatedId;

  @override
  List<Object?> get props => [code, field, relatedId];
}
