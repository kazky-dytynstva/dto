import 'package:dto/dto.dart';
import 'package:dto/src/utils/to_json.dart';
import 'package:equatable/equatable.dart';
import 'package:test/test.dart';

import '../../test_data/test_data.dart';

void main() {
  final personMin = getPerson();
  final personFull = getPersonFull();

  test('GIVEN instance THEN verify it is equatable', () {
    expect(personFull, isA<Equatable>());
  });

  test('GIVEN instance THEN verify it is ToJsonItem', () {
    expect(personFull, isA<ToJsonItem>());
  });

  test('GIVEN instance THEN verify all props correct', () {
    const props = [
      personId,
      personName,
      personUrl,
      personInfo,
    ];
    expect(personFull.props, equals(props));
  });

  test('GIVEN instance with min params THEN all props correct', () {
    const props = [
      personId,
      personName,
      null,
      null,
    ];
    expect(personMin.props, equals(props));
  });

  test('GIVEN same params and 2 instances THEN objects are equal', () {
    const id = 777;
    const name = 'custom name';
    const info = 'custom info';
    const url = 'custom url';
    final instanceOne = getPersonFull(id: id, name: name, info: info, url: url);
    final instanceTwo = getPersonFull(id: id, name: name, info: info, url: url);

    expect(instanceOne, equals(instanceTwo));
  });

  test('GIVEN json with min params THEN parsed correctly', () {
    final person = PersonDto.fromJson(personJsonWithMinFields);
    expect(person, equals(personMin));
  });

  test('GIVEN json with all params THEN parsed correctly', () {
    final person = PersonDto.fromJson(personJsonWithAllFields);
    expect(person, equals(personFull));
  });

  test('GIVEN model with all params THEN converted to json correctly', () {
    final model = personFull;
    expect(model.toJson(), equals(personJsonWithAllFields));
  });
}
