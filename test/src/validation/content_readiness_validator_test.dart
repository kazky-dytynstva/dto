import 'package:dto/content_validation.dart';
import 'package:dto/dto.dart';
import 'package:test/test.dart';

const _validator = ContentReadinessValidator();
const _image = MediaFileEvidence(
  byteLength: 128,
  extension: 'jpg',
  isDecodable: true,
);
const _photo = MediaPairEvidence(original: _image, thumbnail: _image);

void main([List<String> arguments = const []]) {
  if (arguments.isNotEmpty) {
    if (arguments.length != 1 ||
        !{'assertions-on', 'assertions-off'}.contains(arguments.single)) {
      throw ArgumentError('Expected assertions-on or assertions-off');
    }
    var assertionsEnabled = false;
    assert(assertionsEnabled = true);
    if (assertionsEnabled != (arguments.single == 'assertions-on')) {
      throw StateError('Unexpected assertion mode');
    }
  }

  test(
    'given existing person and hidden tale DTOs '
    'when converted to readiness inputs then wire data remains unchanged',
    () {
      final person = PersonDto(
        id: 3,
        name: 'Person',
        surname: '',
        gender: PersonGenderDto.female,
        url: null,
        info: null,
        roles: [PersonRoleDto.author],
        createDate: DateTime.utc(2026),
        updateDate: null,
      );
      final tale = TaleDto(
        id: 7,
        name: 'Fixture Tale',
        summary: 'a' * TaleDto.summaryMinLength,
        tags: {TaleTag.text, TaleTag.audio},
        createDate: DateTime.utc(2026),
        updateDate: null,
        text: TextContentDto(
          items: [
            const ContentItem.image(imageIndex: 0),
            const ContentItem.text(text: 'Text'),
          ],
          minReadingTime: 1,
          maxReadingTime: 2,
        ),
        audio: AudioContentDto(
          fileSize: 128,
          duration: const Duration(seconds: 2),
        ),
        crew: CrewDto(authors: [3]),
        adminConfig: AdminConfigDto(
          isHidden: true,
          isReviewed: true,
          comment: 'Note',
        ),
      );
      final expectedJson = [person.toJson(), tale.toJson()];
      final personInput = PersonReadinessInput.fromDto(person, photo: _photo);
      final taleInput = TaleReadinessInput.fromDto(
        tale,
        images: const [IndexedImageEvidence(index: 0, media: _photo)],
        audioFiles: _audioFiles,
      );

      expect(_validator.validatePerson(personInput), isEmpty);
      expect(_validator.validateTale(taleInput, readyPersonIds: {3}), isEmpty);
      expect([person.toJson(), tale.toJson()], expectedJson);
      final expectedObject = [
        const ContentValidationIssue(
          ContentValidationCode.missingMedia,
          'photo.original',
        ),
        const ContentValidationIssue(
          ContentValidationCode.missingMedia,
          'photo.thumbnail',
        ),
      ];
      expect(
        _validator.validatePerson(
          PersonReadinessInput.fromDto(
            person,
            photo: const MediaPairEvidence(),
          ),
        ),
        expectedObject,
      );
      final hiddenWithoutImages = TaleReadinessInput.fromDto(
        tale,
        images: [],
        audioFiles: _audioFiles,
      );
      expect(
        _validator.validateTale(hiddenWithoutImages, readyPersonIds: {3}),
        isNotEmpty,
      );
    },
  );

  test('given negative IDs and an update before creation '
      'when readiness is checked then invalid metadata is rejected', () {
    final input = PersonReadinessInput(
      id: -1,
      name: 'Person',
      gender: PersonGenderDto.male,
      createDate: DateTime.utc(2026),
      updateDate: DateTime.utc(2025),
      photo: _photo,
    );
    final expectedObject = [
      const ContentValidationIssue(ContentValidationCode.invalidId, 'id'),
      const ContentValidationIssue(
        ContentValidationCode.updateNotAfterCreate,
        'updateDate',
      ),
    ];
    expect(_validator.validatePerson(input), expectedObject);
  });

  test('given invalid reference IDs in the supplied ready-person set '
      'when readiness is checked then invalid IDs cannot be authorized', () {
    final input = _tale(
      crew: {
        PersonRoleDto.author: [-1, PersonDto.stubId],
      },
    );
    final expectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.missingReadyPerson,
        'crew.author',
        relatedId: -1,
      ),
      const ContentValidationIssue(
        ContentValidationCode.missingReadyPerson,
        'crew.author',
        relatedId: PersonDto.stubId,
      ),
    ];
    expect(
      _validator.validateTale(input, readyPersonIds: {-1, PersonDto.stubId}),
      expectedObject,
    );
  });

  for (final length in [1, 2, 50, 51]) {
    test('given a person name of length $length '
        'when readiness is checked then the existing length bounds apply', () {
      final input = PersonReadinessInput(
        id: 1,
        name: 'a' * length,
        surname: '',
        gender: PersonGenderDto.female,
        createDate: DateTime.utc(2026),
        photo: _photo,
      );
      final expectedObject = [
        if (length < 2 || length > 50)
          const ContentValidationIssue(
            ContentValidationCode.lengthOutOfRange,
            'name',
          ),
      ];
      expect(_validator.validatePerson(input), expectedObject);
    });
  }

  for (final length in [3, 4, 50, 51]) {
    test('given a tale name of length $length '
        'when readiness is checked then the existing length bounds apply', () {
      final expectedObject = [
        if (length < 4 || length > 50)
          const ContentValidationIssue(
            ContentValidationCode.lengthOutOfRange,
            'name',
          ),
      ];
      expect(
        _validator.validateTale(_tale(name: 'a' * length), readyPersonIds: {}),
        expectedObject,
      );
    });
  }

  for (final length in [119, 120, 200, 201]) {
    test('given a tale summary of length $length '
        'when readiness is checked then the existing length bounds apply', () {
      final expectedObject = [
        if (length < 120 || length > 200)
          const ContentValidationIssue(
            ContentValidationCode.lengthOutOfRange,
            'summary',
          ),
      ];
      expect(
        _validator.validateTale(
          _tale(summary: 'a' * length),
          readyPersonIds: {},
        ),
        expectedObject,
      );
    });
  }

  test('given corrupt and incorrectly named photo files '
      'when readiness is checked then both media issues are reported', () {
    final input = PersonReadinessInput(
      id: 1,
      name: 'Person',
      gender: PersonGenderDto.female,
      createDate: DateTime.utc(2026),
      roles: [],
      photo: const MediaPairEvidence(
        original: MediaFileEvidence(
          byteLength: 0,
          extension: 'jpg',
          isDecodable: false,
        ),
        thumbnail: MediaFileEvidence(
          byteLength: 128,
          extension: 'png',
          isDecodable: true,
        ),
      ),
    );
    final expectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.emptyCollection,
        'roles',
      ),
      const ContentValidationIssue(
        ContentValidationCode.invalidMedia,
        'photo.original',
      ),
      const ContentValidationIssue(
        ContentValidationCode.invalidThumbnailFormat,
        'photo.thumbnail',
      ),
    ];
    expect(_validator.validatePerson(input), expectedObject);
  });

  test('given audio-only and combined tales '
      'when readiness is checked then both content variants are accepted', () {
    for (final includeText in [false, true]) {
      final input = _tale(
        includeText: includeText,
        tags: {TaleTag.audio, if (includeText) TaleTag.text},
        audio: const AudioReadinessInput(
          fileSize: 128,
          duration: Duration(seconds: 2),
        ),
        audioFiles: _audioFiles,
      );
      expect(_validator.validateTale(input, readyPersonIds: {}), isEmpty);
    }
  });

  test('given incomplete audio metadata and missing files '
      'when readiness is checked then all audio problems are returned', () {
    final input = _tale(
      includeText: false,
      tags: {TaleTag.audio},
      audio: const AudioReadinessInput(),
    );
    final expectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.invalidAudioMetadata,
        'audio.fileSize',
      ),
      const ContentValidationIssue(
        ContentValidationCode.invalidAudioMetadata,
        'audio.duration',
      ),
      const ContentValidationIssue(
        ContentValidationCode.missingMedia,
        'audioFiles.original',
      ),
      const ContentValidationIssue(
        ContentValidationCode.missingMedia,
        'audioFiles.thumbnail',
      ),
    ];
    expect(_validator.validateTale(input, readyPersonIds: {}), expectedObject);
  });

  test('given audio metadata that disagrees with the actual thumbnail length '
      'when readiness is checked then size mismatch is returned', () {
    final input = _tale(
      includeText: false,
      tags: {TaleTag.audio},
      audio: const AudioReadinessInput(
        fileSize: 129,
        duration: Duration(seconds: 2),
      ),
      audioFiles: _audioFiles,
    );
    final expectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.audioSizeMismatch,
        'audio.fileSize',
      ),
    ];
    expect(_validator.validateTale(input, readyPersonIds: {}), expectedObject);
  });

  test('given audio files without audio content '
      'when readiness is checked then unexpected media is reported', () {
    final expectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.unexpectedMedia,
        'audioFiles',
      ),
    ];
    expect(
      _validator.validateTale(
        _tale(audioFiles: _audioFiles),
        readyPersonIds: {},
      ),
      expectedObject,
    );
  });

  test(
    'given a tale with neither text nor audio '
    'when readiness is checked then a category tag alone is insufficient',
    () {
      final expectedObject = [
        const ContentValidationIssue(
          ContentValidationCode.missingContent,
          'content',
        ),
      ];
      expect(
        _validator.validateTale(
          _tale(includeText: false, tags: {TaleTag.poem}),
          readyPersonIds: {},
        ),
        expectedObject,
      );
    },
  );

  test('given empty tags and empty text '
      'when readiness is checked then partial nested data does not throw', () {
    final input = _tale(tags: {}, text: TextReadinessInput());
    final expectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.emptyCollection,
        'tags',
      ),
      const ContentValidationIssue(
        ContentValidationCode.tagContentMismatch,
        'tags.text',
      ),
      const ContentValidationIssue(
        ContentValidationCode.emptyCollection,
        'text.items',
      ),
      const ContentValidationIssue(
        ContentValidationCode.invalidReadingTime,
        'text.minReadingTime',
      ),
      const ContentValidationIssue(
        ContentValidationCode.invalidReadingTime,
        'text.maxReadingTime',
      ),
    ];
    expect(_validator.validateTale(input, readyPersonIds: {}), expectedObject);
  });

  test(
    'given out-of-order text images and invalid reading times '
    'when readiness is checked then sequence and timing errors are returned',
    () {
      final input = _tale(
        text: TextReadinessInput(
          items: [
            const ContentItem.text(text: 'Text'),
            const ContentItem.image(imageIndex: 2),
          ],
          minReadingTime: 0,
          maxReadingTime: 0,
        ),
      );
      final expectedObject = [
        const ContentValidationIssue(
          ContentValidationCode.invalidImageSequence,
          'text.items[0]',
        ),
        const ContentValidationIssue(
          ContentValidationCode.invalidImageSequence,
          'text.items[1]',
        ),
        const ContentValidationIssue(
          ContentValidationCode.missingImageReference,
          'text.items[1]',
        ),
        const ContentValidationIssue(
          ContentValidationCode.invalidReadingTime,
          'text.minReadingTime',
        ),
        const ContentValidationIssue(
          ContentValidationCode.invalidReadingTime,
          'text.maxReadingTime',
        ),
      ];
      expect(
        _validator.validateTale(input, readyPersonIds: {}),
        expectedObject,
      );
    },
  );

  test(
    'given adjacent image items '
    'when readiness is checked then the editor image-order rule is retained',
    () {
      final input = _tale(
        images: const [
          IndexedImageEvidence(index: 0, media: _photo),
          IndexedImageEvidence(index: 1, media: _photo),
        ],
        text: TextReadinessInput(
          items: [
            const ContentItem.image(imageIndex: 0),
            const ContentItem.image(imageIndex: 1),
          ],
          minReadingTime: 1,
          maxReadingTime: 2,
        ),
      );
      final expectedObject = [
        const ContentValidationIssue(
          ContentValidationCode.adjacentImages,
          'text.items[1]',
        ),
      ];
      expect(
        _validator.validateTale(input, readyPersonIds: {}),
        expectedObject,
      );
    },
  );

  for (final indices in [
    [0, 0],
    [0, 2],
    [-1, 0],
  ]) {
    test(
      'given image indices $indices '
      'when readiness is checked then duplicate gaps or negatives are rejected',
      () {
        final input = _tale(
          images: [
            for (final index in indices)
              IndexedImageEvidence(index: index, media: _photo),
          ],
        );
        final expectedObject = [
          const ContentValidationIssue(
            ContentValidationCode.invalidImageSequence,
            'images',
          ),
        ];
        expect(
          _validator.validateTale(input, readyPersonIds: {}),
          expectedObject,
        );
      },
    );
  }

  test('given an empty crew or unsupported crew role '
      'when readiness is checked then invalid crew structure is reported', () {
    final emptyExpectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.emptyCollection,
        'crew',
      ),
    ];
    final roleExpectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.invalidCrewRole,
        'crew.crew',
      ),
    ];
    expect(
      _validator.validateTale(_tale(crew: {}), readyPersonIds: {}),
      emptyExpectedObject,
    );
    expect(
      _validator.validateTale(
        _tale(
          crew: {
            PersonRoleDto.crew: [3],
          },
        ),
        readyPersonIds: {3},
      ),
      roleExpectedObject,
    );
  });

  test('given crew members present in the ready-person manifest '
      'when readiness is checked then references resolve', () {
    expect(
      _validator.validateTale(
        _tale(
          crew: {
            PersonRoleDto.author: [3],
          },
        ),
        readyPersonIds: {3},
      ),
      isEmpty,
    );
  });

  test(
    'given mutable source collections '
    'when inputs are created then snapshots and returned issues are immutable',
    () {
      final tags = {TaleTag.text};
      final members = [3];
      final input = _tale(tags: tags, crew: {PersonRoleDto.author: members});
      tags.clear();
      members.clear();
      expect(input.tags, {TaleTag.text});
      expect(input.crew![PersonRoleDto.author], [3]);
      expect(
        () => input.crew![PersonRoleDto.author]!.clear(),
        throwsUnsupportedError,
      );
      expect(() => input.tags!.clear(), throwsUnsupportedError);
      final issues = _validator.validateTale(input, readyPersonIds: {});
      expect(() => issues.clear(), throwsUnsupportedError);
    },
  );
  test('given a complete text tale with optional crew absent '
      'when readiness is checked then no issues are returned', () {
    expect(_validator.validateTale(_tale(), readyPersonIds: {}), isEmpty);
  });

  test('given unresolved crew and a missing image '
      'when readiness is checked then dependencies are reported', () {
    final input = _tale(
      images: [],
      crew: {
        PersonRoleDto.author: [3],
      },
    );
    final expectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.missingMedia,
        'images',
      ),
      const ContentValidationIssue(
        ContentValidationCode.missingImageReference,
        'text.items[0]',
      ),
      const ContentValidationIssue(
        ContentValidationCode.missingReadyPerson,
        'crew.author',
        relatedId: 3,
      ),
    ];
    expect(_validator.validateTale(input, readyPersonIds: {}), expectedObject);
  });

  test('given text without its tag '
      'when readiness is checked then tag mismatch is reported', () {
    final expectedObject = [
      const ContentValidationIssue(
        ContentValidationCode.tagContentMismatch,
        'tags.text',
      ),
    ];
    expect(
      _validator.validateTale(_tale(tags: {TaleTag.poem}), readyPersonIds: {}),
      expectedObject,
    );
  });
  test('given a complete person without optional fields '
      'when readiness is checked then no issues are returned', () {
    final input = PersonReadinessInput(
      id: 0,
      name: 'Person',
      gender: PersonGenderDto.female,
      createDate: DateTime.utc(2026),
      photo: _photo,
    );

    expect(_validator.validatePerson(input), isEmpty);
  });

  test('given an empty person '
      'when readiness is checked then all required fields are reported', () {
    final expectedObject = [
      const ContentValidationIssue(ContentValidationCode.invalidId, 'id'),
      const ContentValidationIssue(ContentValidationCode.requiredValue, 'name'),
      const ContentValidationIssue(
        ContentValidationCode.requiredValue,
        'gender',
      ),
      const ContentValidationIssue(
        ContentValidationCode.requiredValue,
        'createDate',
      ),
      const ContentValidationIssue(
        ContentValidationCode.missingMedia,
        'photo.original',
      ),
      const ContentValidationIssue(
        ContentValidationCode.missingMedia,
        'photo.thumbnail',
      ),
    ];

    expect(_validator.validatePerson(PersonReadinessInput()), expectedObject);
  });

  test('given invalid person fields '
      'when readiness is checked then independent errors are accumulated', () {
    final input = PersonReadinessInput(
      id: PersonDto.stubId,
      name: '',
      surname: 'x',
      gender: PersonGenderDto.male,
      url: Uri.parse('short'),
      roles: [PersonRoleDto.author, PersonRoleDto.author],
      createDate: DateTime.utc(2026),
      updateDate: DateTime.utc(2026),
      photo: _photo,
    );
    final expectedObject = [
      const ContentValidationIssue(ContentValidationCode.invalidId, 'id'),
      const ContentValidationIssue(
        ContentValidationCode.lengthOutOfRange,
        'name',
      ),
      const ContentValidationIssue(
        ContentValidationCode.lengthOutOfRange,
        'surname',
      ),
      const ContentValidationIssue(
        ContentValidationCode.lengthOutOfRange,
        'url',
      ),
      const ContentValidationIssue(
        ContentValidationCode.updateNotAfterCreate,
        'updateDate',
      ),
      const ContentValidationIssue(
        ContentValidationCode.duplicateValue,
        'roles',
      ),
    ];

    expect(_validator.validatePerson(input), expectedObject);
  });
}

TaleReadinessInput _tale({
  String name = 'Fixture Tale',
  String? summary,
  Set<TaleTag> tags = const {TaleTag.text},
  List<IndexedImageEvidence> images = const [
    IndexedImageEvidence(index: 0, media: _photo),
  ],
  Map<PersonRoleDto, List<int>>? crew,
  bool includeText = true,
  TextReadinessInput? text,
  AudioReadinessInput? audio,
  MediaPairEvidence audioFiles = const MediaPairEvidence(),
}) => TaleReadinessInput(
  id: 7,
  name: name,
  summary: summary ?? 'a' * TaleDto.summaryMinLength,
  createDate: DateTime.utc(2026),
  tags: tags,
  text: !includeText
      ? null
      : text ??
            TextReadinessInput(
              items: [
                const ContentItem.image(imageIndex: 0),
                const ContentItem.text(text: 'Text'),
              ],
              minReadingTime: 1,
              maxReadingTime: 2,
            ),
  images: images,
  crew: crew,
  audio: audio,
  audioFiles: audioFiles,
);

const _audioFiles = MediaPairEvidence(
  original: MediaFileEvidence(
    byteLength: 256,
    extension: 'wav',
    isDecodable: true,
  ),
  thumbnail: MediaFileEvidence(
    byteLength: 128,
    extension: 'm4a',
    isDecodable: true,
  ),
);
