import 'package:test/test.dart';

/// This can be used to match the message of an [AssertionError]
///
/// Note:
///   - it will fail if the error is not an [AssertionError]
Matcher throwsAssertErrorWithMessage(String expectedMessage) {
  return throwsA(wrapMatcher(_AssertMessageMatcher(expectedMessage)));
}

class _AssertMessageMatcher extends Matcher {
  final String expectedMessage;

  _AssertMessageMatcher(this.expectedMessage);
  @override
  Description describe(Description description) {
    return description
        .add('an $AssertionError with message that equals to ')
        .addDescriptionOf(expectedMessage);
  }

  @override
  bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
    if (item is! AssertionError) return false;
    return item.message == expectedMessage;
  }
}
