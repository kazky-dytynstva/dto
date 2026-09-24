[![Code Quality](https://github.com/kazky-dytynstva/dto/actions/workflows/checks.yaml/badge.svg)](https://github.com/kazky-dytynstva/dto/actions/workflows/checks.yaml)

----------

### This package contains dto objects that are used in the [mobile application](https://github.com/kazky-dytynstva/mobile-app/).

## Content Readiness Validation

Import `package:dto/content_validation.dart` for the separate pure-Dart
`ContentReadinessValidator` API. Existing `package:dto/dto.dart` exports,
constructors and JSON serialization are unchanged. This API is preparatory;
consumers must explicitly adopt a pinned package revision before it protects
their save or publication paths.

`validatePerson(PersonReadinessInput)` and
`validateTale(TaleReadinessInput, readyPersonIds: ...)` return an immutable list
of `ContentValidationIssue` objects with a code, field path and optional related
person ID. No localized messages, filesystem reads, Flutter dependencies,
DTO construction, or assertion-based checks occur during validation.

The nullable input classes are in-memory snapshots, not persisted draft DTOs.
They accept partial fields so callers can inspect problems without constructing
an invalid production DTO. Collections are copied and frozen. `fromDto`
factories support rechecking existing records without modifying them.

The checks cover existing name/summary/surname/URL length bounds, nonnegative
non-stub IDs (zero remains allowed), required gender/creation time, strictly
later update time, optional-but-nonempty unique person roles, text/audio tag
agreement, at least one content type, reading times, sequential text image
references, no adjacent images, indexed image pairs, positive audio metadata,
thumbnail byte length, and crew references to ready people. An absent crew is
valid; a present crew must contain a member. Empty surname and absent URL,
roles and profile information remain optional. No new profile-info length or
URL-scheme policy is introduced. Hidden status never relaxes readiness.

Callers provide `MediaFileEvidence` and `MediaPairEvidence`. Missing evidence
means missing media; zero-length or undecodable evidence means invalid media.
Image thumbnails must have extension `jpg`, audio thumbnails `m4a`, matching
current mobile paths. The caller must actually read and decode the files and
provide evidence for the exact bytes that will be written. This library does
not verify hashes, paths, image dimensions, codecs or audio duration against
the physical file. File layout, path/symlink safety, original-image admission
rules, and transactional rechecks remain responsibilities of adapters.

`readyPersonIds` must come from independently validated ready records, never
drafts or an unvalidated list. The validator rejects negative/stub references
even if supplied in that set. New content IDs must be allocated before final
candidate validation. A missing optional surname is normalized to an empty
string by the DTO-building adapter; the validator does not mutate input.
Unresolved draft references must be resolved or reported by the authoring
adapter before producing a candidate. This is per-record validation, not
collection uniqueness, branch-conflict, JSON type/schema or publication proof.

For JSON/gzip consistency, compare the decompressed data with the ready
records' `toProdJson()` projection. Do not compare a full editorial DTO against
its stripped production DTO: review/comment fields intentionally differ.

### Verification

Use the SDK pinned in `.fvmrc` (Flutter 3.47.5 / Dart 3.13.4):

```sh
fvm dart test
fvm dart analyze lib/content_validation.dart lib/src/validation test/src/validation
fvm dart run --no-enable-asserts test/src/validation/content_readiness_validator_test.dart assertions-off
fvm dart run --enable-asserts test/src/validation/content_readiness_validator_test.dart assertions-on
```

The direct runs verify their assertion mode before executing the same tests.
Local macOS verification: 190 total tests passed; all 36 readiness tests also
passed separately with assertions enabled and disabled. CI reads the same FVM
pin and Fastlane invokes `fvm dart`; hosted CI and Windows are not yet verified.




