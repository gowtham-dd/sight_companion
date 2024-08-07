import '../models/braille.dart';
import 'package:test/test.dart';

/// Tests:
void main() {
  test('numberOfDots should be 6', () {
    expect(Braille.numberOfDots, 6);
  });
  test('BrailleAsBoolList equality and hash check with mutability', () {
    late final BrailleAsBoolList a, b, c;
    a = BrailleAsBoolList();
    b = BrailleAsBoolList();
    c = BrailleAsBoolList(List.filled(6, true));
    expect(a == b, true);
    expect(a == c, false);
    expect(a.hashCode == b.hashCode, true);
    expect(a.hashCode == c.hashCode, false);

    b.value[0] = true;
    expect(a.hashCode == b.hashCode, false);
    expect(a == b, false);
  });
  test('MyTestClass equality and hash check with mutability', () {
    late final MyTestClass a, b, c;
    a = MyTestClass();
    b = MyTestClass();
    c = MyTestClass(List.filled(6, true));
    /*print(b.hashCode);
    print(b.runtimeType);*/
    expect(a == b, true);
    expect(a == c, false);
    expect(a.hashCode == b.hashCode, true);
    expect(a.hashCode == c.hashCode, false);

    b.value[0] = true;
    /*print(b.hashCode);*/
    expect(a.hashCode == b.hashCode, false);
    expect(a == b, false);
  });
  test(
      'BrailleAsBoolList operator == won\'t crash if the other obj. is not of the same type',
      () {
    var a, b, c;
    a = BrailleAsBoolList();
    b = null;
    c = "abc";
    expect(a == b, false);
    expect(b == a, false);
    expect(b == c, false);
    expect(c == b, false);
  });
  test(
      'MyTestClass operator == won\'t crash if the other obj. is not of the same type',
      () {
    var a, b, c;
    a = MyTestClass();
    b = null;
    c = "abc";
    expect(a == b, false);
    expect(b == a, false);
    expect(b == c, false);
    expect(c == b, false);
  });
}
