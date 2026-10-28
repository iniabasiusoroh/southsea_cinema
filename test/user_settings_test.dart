import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main(){

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  });
  test('UserSettings defaults to empty values and false newsletter', (){
    const UserSettings settings = UserSettings();
    expect(settings.address, isEmpty);
    expect(settings.email, isEmpty);
    expect(settings.patronNumber, '0');
    expect(settings.receiveNewsletter, isFalse);
  });

  test('UserSettings stores the configured values', (){
    const UserSettings settings = UserSettings(
      address: 'PO1 1DZ',
      email: '123456@gmail.com',
      patronNumber: '12345',
      receiveNewsletter: true,
    );
    expect(settings.address, 'PO1 1DZ');
    expect(settings.email, '123456@gmail.com');
    expect(settings.patronNumber, '12345');
    expect(settings.receiveNewsletter, isTrue);
  });

  test('UserSettings keeps defaults for values that are not configured', (){
    const UserSettings settings = UserSettings(email: 'user@example.com');

    expect(settings.address, isEmpty);
    expect(settings.email, 'user@example.com');
    expect(settings.patronNumber, '0');
    expect(settings.receiveNewsletter, isFalse);
  });
}