// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import '../lib/utils/validator.dart';

import 'package:q8/main.dart';

void main() {
  testWidgets('Empty email', (WidgetTester tester) async {
    var result = FieldValidator.validateEmail('');
    expect(result, 'Enter Email');
  });
  testWidgets('Invalid Email', (WidgetTester tester) async {
    var result = FieldValidator.validateEmail('abcd');
    expect(result, 'Enter valid Email');
  });
  testWidgets('Short Password', (WidgetTester tester) async {
    var result = FieldValidator.validatePassword('abcd');
    expect(result, 'Password must be more than 6 characters');
  });
}
