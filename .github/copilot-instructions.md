# Workspace Instructions

## Flutter/Dart Commands

- Always use `fvm dart` instead of `dart` for Dart commands

## Testing Standards

- Use the Given-When-Then structure for all test descriptions
- Refer to `.vscode/test.code-snippets` for the standard test template
- keys for json should be extracted to constants and should be used in the code instead of hardcoded strings
- when we `expect` json - we should use `expectedJson` object instead of testing each field separately
- when we expect some object to be equal to another - we should use expectedObject instead of testing each field separately