class AuthService {
  AuthService._internal();
  static final AuthService instance = AuthService._internal();

  final List<Map<String, String>> _users = [];

  Map<String, String>? _currentUser;

  bool get isLoggedIn => _currentUser != null;
  String get currentName => _currentUser?['name'] ?? '';
  String get currentEmail => _currentUser?['email'] ?? '';
  String get currentAddress => _currentUser?['address'] ?? '';
  int get currentRating => int.tryParse(_currentUser?['rating'] ?? '') ?? 0;
  String get currentLanguage =>
      _currentUser?['language'] ?? 'Bahasa Indonesia';

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
      'address': '',
      'rating': '0',
      'language': 'Bahasa Indonesia',
    });
    return true;
  }

  bool login({required String email, required String password}) {
    for (final user in _users) {
      if (user['email']!.toLowerCase() == email.toLowerCase() &&
          user['password'] == password) {
        _currentUser = user;
        return true;
      }
    }
    return false;
  }

  void logout() {
    _currentUser = null;
  }

  bool updateEmail({required String newEmail}) {
    final user = _currentUser;
    if (user == null) return false;

    final email = newEmail.trim();

    final dipakaiAkunLain = _users.any(
      (u) =>
          !identical(u, user) &&
          u['email']!.toLowerCase() == email.toLowerCase(),
    );
    if (dipakaiAkunLain) return false;

    user['email'] = email;
    return true;
  }

  bool updateAddress({required String newAddress}) {
    final user = _currentUser;
    if (user == null) return false;

    user['address'] = newAddress.trim();
    return true;
  }

  bool updateRating({required int rating}) {
    final user = _currentUser;
    if (user == null) return false;
    if (rating < 1 || rating > 5) return false;

    user['rating'] = rating.toString();
    return true;
  }

  bool updateLanguage({required String language}) {
    final user = _currentUser;
    if (user == null) return false;

    user['language'] = language;
    return true;
  }
}