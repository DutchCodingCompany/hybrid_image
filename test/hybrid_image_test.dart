import 'package:flutter_test/flutter_test.dart';

import 'package:hybrid_image/hybrid_image.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  test('HybridNetworkImage does not accept empty url', () {
    expect(() => HybridImage.network(imageUrl: ''), throwsAssertionError);
  });

  test('HybridNetworkImage does not accept invalid url', () {
    expect(() => HybridImage.network(imageUrl: 'test'), throwsAssertionError);
  });

  test('HybridNetworkImage does not throw exception on valid url', () {
    expect(
      () => HybridImage.network(imageUrl: 'https://test.com/image.jpg'),
      returnsNormally,
    );
  });
}
