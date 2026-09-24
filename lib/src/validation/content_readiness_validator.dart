import 'package:dto/src/person/person_dto.dart';
import 'package:dto/src/person/person_role_dto.dart';
import 'package:dto/src/tale/content/text_content_dto.dart';
import 'package:dto/src/tale/tale_dto.dart';
import 'package:dto/src/validation/content_validation_issue.dart';
import 'package:dto/src/validation/readiness_input.dart';

class ContentReadinessValidator {
  const ContentReadinessValidator();

  List<ContentValidationIssue> validatePerson(PersonReadinessInput input) {
    final issues = <ContentValidationIssue>[];
    _validateIdentity(input.id, PersonDto.stubId, issues);
    _validateLength(
      input.name,
      'name',
      PersonDto.nameMinLength,
      PersonDto.nameMaxLength,
      issues,
    );
    if (input.surname != null && input.surname!.isNotEmpty) {
      _validateLength(
        input.surname,
        'surname',
        PersonDto.surnameMinLength,
        PersonDto.surnameMaxLength,
        issues,
      );
    }
    if (input.gender == null) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.requiredValue,
          'gender',
        ),
      );
    }
    if (input.url != null) {
      _validateLength(
        input.url.toString(),
        'url',
        PersonDto.urlMinLength,
        PersonDto.urlMaxLength,
        issues,
      );
    }
    _validateDates(input.createDate, input.updateDate, issues);
    final roles = input.roles;
    if (roles != null) {
      if (roles.isEmpty) {
        issues.add(
          const ContentValidationIssue(
            ContentValidationCode.emptyCollection,
            'roles',
          ),
        );
      }
      if (roles.length != roles.toSet().length) {
        issues.add(
          const ContentValidationIssue(
            ContentValidationCode.duplicateValue,
            'roles',
          ),
        );
      }
    }
    _validateMediaPair(input.photo, 'photo', 'jpg', issues);
    return List.unmodifiable(issues);
  }

  List<ContentValidationIssue> validateTale(
    TaleReadinessInput input, {
    required Set<int> readyPersonIds,
  }) {
    final issues = <ContentValidationIssue>[];
    _validateIdentity(input.id, TaleDto.stubId, issues);
    _validateLength(
      input.name,
      'name',
      TaleDto.nameMinLength,
      TaleDto.nameMaxLength,
      issues,
    );
    _validateLength(
      input.summary,
      'summary',
      TaleDto.summaryMinLength,
      TaleDto.summaryMaxLength,
      issues,
    );
    _validateDates(input.createDate, input.updateDate, issues);
    final tags = input.tags;
    if (tags == null || tags.isEmpty) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.emptyCollection,
          'tags',
        ),
      );
    }
    for (final entry in {
      TaleTag.text: input.text != null,
      TaleTag.audio: input.audio != null,
    }.entries) {
      if ((tags?.contains(entry.key) ?? false) != entry.value) {
        issues.add(
          ContentValidationIssue(
            ContentValidationCode.tagContentMismatch,
            'tags.${entry.key.name}',
          ),
        );
      }
    }
    if (input.text == null && input.audio == null) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.missingContent,
          'content',
        ),
      );
    }
    if (input.images.isEmpty) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.missingMedia,
          'images',
        ),
      );
    }
    final imageIndices = input.images.map((image) => image.index).toList()
      ..sort();
    for (var position = 0; position < imageIndices.length; position++) {
      if (imageIndices[position] != position) {
        issues.add(
          const ContentValidationIssue(
            ContentValidationCode.invalidImageSequence,
            'images',
          ),
        );
        break;
      }
    }
    for (var position = 0; position < input.images.length; position++) {
      _validateMediaPair(
        input.images[position].media,
        'images[$position]',
        'jpg',
        issues,
      );
    }
    final text = input.text;
    if (text != null) _validateText(text, imageIndices.toSet(), issues);
    final audio = input.audio;
    if (audio != null) {
      if (audio.fileSize == null || audio.fileSize! <= 0) {
        issues.add(
          const ContentValidationIssue(
            ContentValidationCode.invalidAudioMetadata,
            'audio.fileSize',
          ),
        );
      }
      if (audio.duration == null || audio.duration! <= Duration.zero) {
        issues.add(
          const ContentValidationIssue(
            ContentValidationCode.invalidAudioMetadata,
            'audio.duration',
          ),
        );
      }
      _validateMediaPair(input.audioFiles, 'audioFiles', 'm4a', issues);
      final thumbnail = input.audioFiles.thumbnail;
      if (thumbnail != null && audio.fileSize != thumbnail.byteLength) {
        issues.add(
          const ContentValidationIssue(
            ContentValidationCode.audioSizeMismatch,
            'audio.fileSize',
          ),
        );
      }
    } else if (input.audioFiles.original != null ||
        input.audioFiles.thumbnail != null) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.unexpectedMedia,
          'audioFiles',
        ),
      );
    }
    final crew = input.crew;
    if (crew != null) {
      if (!crew.values.any((members) => members.isNotEmpty)) {
        issues.add(
          const ContentValidationIssue(
            ContentValidationCode.emptyCollection,
            'crew',
          ),
        );
      }
      for (final role in PersonRoleDto.values) {
        final members = crew[role];
        if (members == null) continue;
        if (role == PersonRoleDto.crew) {
          issues.add(
            const ContentValidationIssue(
              ContentValidationCode.invalidCrewRole,
              'crew.crew',
            ),
          );
        }
        for (final memberId in members.toSet()) {
          if (memberId < 0 ||
              memberId == PersonDto.stubId ||
              !readyPersonIds.contains(memberId)) {
            issues.add(
              ContentValidationIssue(
                ContentValidationCode.missingReadyPerson,
                'crew.${role.name}',
                relatedId: memberId,
              ),
            );
          }
        }
      }
    }
    return List.unmodifiable(issues);
  }

  void _validateText(
    TextReadinessInput text,
    Set<int> availableImages,
    List<ContentValidationIssue> issues,
  ) {
    final items = text.items;
    if (items == null || items.length < 2) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.emptyCollection,
          'text.items',
        ),
      );
    }
    if (items != null && items.isNotEmpty) {
      final first = items.first;
      if (first is! ContentItemImage || first.imageIndex != 0) {
        issues.add(
          const ContentValidationIssue(
            ContentValidationCode.invalidImageSequence,
            'text.items[0]',
          ),
        );
      }
      var expectedImageIndex = 0;
      var previousIsImage = false;
      for (var position = 0; position < items.length; position++) {
        final item = items[position];
        if (item is ContentItemImage) {
          final field = 'text.items[$position]';
          if (item.imageIndex != expectedImageIndex) {
            issues.add(
              ContentValidationIssue(
                ContentValidationCode.invalidImageSequence,
                field,
              ),
            );
          }
          if (!availableImages.contains(item.imageIndex)) {
            issues.add(
              ContentValidationIssue(
                ContentValidationCode.missingImageReference,
                field,
              ),
            );
          }
          if (previousIsImage) {
            issues.add(
              ContentValidationIssue(
                ContentValidationCode.adjacentImages,
                field,
              ),
            );
          }
          expectedImageIndex++;
        }
        previousIsImage = item is ContentItemImage;
      }
    }
    if (text.minReadingTime == null || text.minReadingTime! <= 0) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.invalidReadingTime,
          'text.minReadingTime',
        ),
      );
    }
    if (text.maxReadingTime == null ||
        text.maxReadingTime! <= 0 ||
        (text.minReadingTime != null &&
            text.maxReadingTime! <= text.minReadingTime!)) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.invalidReadingTime,
          'text.maxReadingTime',
        ),
      );
    }
  }

  void _validateIdentity(
    int? id,
    int stubId,
    List<ContentValidationIssue> issues,
  ) {
    if (id == null || id < 0 || id == stubId) {
      issues.add(
        const ContentValidationIssue(ContentValidationCode.invalidId, 'id'),
      );
    }
  }

  void _validateLength(
    String? value,
    String field,
    int minimum,
    int maximum,
    List<ContentValidationIssue> issues,
  ) {
    if (value == null) {
      issues.add(
        ContentValidationIssue(ContentValidationCode.requiredValue, field),
      );
    } else if (value.length < minimum || value.length > maximum) {
      issues.add(
        ContentValidationIssue(ContentValidationCode.lengthOutOfRange, field),
      );
    }
  }

  void _validateDates(
    DateTime? createDate,
    DateTime? updateDate,
    List<ContentValidationIssue> issues,
  ) {
    if (createDate == null) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.requiredValue,
          'createDate',
        ),
      );
    } else if (updateDate != null && !updateDate.isAfter(createDate)) {
      issues.add(
        const ContentValidationIssue(
          ContentValidationCode.updateNotAfterCreate,
          'updateDate',
        ),
      );
    }
  }

  void _validateMediaPair(
    MediaPairEvidence pair,
    String field,
    String thumbnailExtension,
    List<ContentValidationIssue> issues,
  ) {
    for (final entry in {
      '$field.original': pair.original,
      '$field.thumbnail': pair.thumbnail,
    }.entries) {
      final file = entry.value;
      if (file == null) {
        issues.add(
          ContentValidationIssue(ContentValidationCode.missingMedia, entry.key),
        );
      } else if (file.byteLength <= 0 ||
          !file.isDecodable ||
          file.extension.isEmpty) {
        issues.add(
          ContentValidationIssue(ContentValidationCode.invalidMedia, entry.key),
        );
      }
    }
    final thumbnail = pair.thumbnail;
    if (thumbnail != null && thumbnail.extension != thumbnailExtension) {
      issues.add(
        ContentValidationIssue(
          ContentValidationCode.invalidThumbnailFormat,
          '$field.thumbnail',
        ),
      );
    }
  }
}
