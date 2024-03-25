import 'package:test/test.dart';
import 'package:vit_logger/src/repositories/event_matcher.dart';

void main() {
  test('should log if event is null', () {
    var instance = EventMatcher();

    // Null matchers
    instance.patterns = null;
    expect(instance.shouldLogEvent(null), true);

    // Empty matchers
    instance.patterns = [];
    expect(instance.shouldLogEvent(null), true);

    instance.patterns = [RegExp('anyRegex')];
    expect(instance.shouldLogEvent(null), true);
  });

  test('should not log if event is not null and instance does not contain a matching regex', () {
    var instance = EventMatcher();

    instance.patterns = [];
    expect(instance.shouldLogEvent('MyEvent'), false);

    instance.patterns = [RegExp('anyRegex')];
    expect(instance.shouldLogEvent('MyEvent'), false);
  });

  test('should log if event is not null and instance contains a matching regex', () {
    var instance = EventMatcher();

    instance.patterns = [RegExp(r'.*event.*', caseSensitive: false)];
    expect(instance.shouldLogEvent('MyEvent'), true);
  });
}
