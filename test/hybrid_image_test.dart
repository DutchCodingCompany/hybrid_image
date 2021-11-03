import 'package:flutter_test/flutter_test.dart';

import 'package:hybrid_image/hybrid_image.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('HybridNetworkImage does not accept empty url', () {
    expect(() => HybridNetworkImage(''), throwsAssertionError);
  });

  test('HybridNetworkImage does not accept invalid url', () {
    expect(() => HybridNetworkImage('test'), throwsAssertionError);
  });

  test('HybridNetworkImage does not throw exception on valid url', () {
    expect(
      () => HybridNetworkImage('https://test.com/image.jpg'),
      returnsNormally,
    );
  });
}
