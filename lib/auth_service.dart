class AuthService {
  AuthService._internal();
  static final AuthService instance = AuthService._internal();

  final List<Map<String, String>> _users = [];

  bool register({
    required String name,
    required String email,
    required String password,
  }) {
    final alreadyExists = _users.any(
      (user) => user['email']!.toLowerCase() == email.toLowerCase(),
    );
    if (alreadyExists) return false;

    _users.add({
      'name': name,
      'email': email,
      'password': password,
    });
    return true;
  }

  bool login({required String email, required String password}) {
    return _users.any(
      (user) =>
          user['email']!.toLowerCase() == email.toLowerCase() &&
          user['password'] == password,
    );
  }
}