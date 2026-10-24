class UserSettings {
  final String address;
  final String email;
  final String patronNumber;

  final bool receiveNewsletter;

  const UserSettings({
    this.address = '',
    this.email = '',
    this.patronNumber = '0',
    this.receiveNewsletter = false,
  });
}