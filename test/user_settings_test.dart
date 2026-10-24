import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main(){
  test('UserSettings defaults to empty values and false newsletter', (){
    const UserSettings settings = UserSettings();
    expect(settings.address, isEmpty);
    expect(settings.email, isEmpty);
    expect(settings.patronNumber, 0);
    expect(settings.receiveNewsletter, isFalse);
  });
}