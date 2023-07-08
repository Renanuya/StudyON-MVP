enum Status {
  loading('loading'),
  success('success'),
  failed('failed'),
  wrongPassword('wrong-password'),
  userNotFound('user-not-found'),
  manyTried('too-many-requests'),
  emailAlreadyInUse('email-already-in-use');

  final String? value;

  const Status(this.value);
}
