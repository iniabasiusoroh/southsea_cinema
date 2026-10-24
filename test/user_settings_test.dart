import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main(){
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
}