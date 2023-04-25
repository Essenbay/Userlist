//Login exceptions
class UserNotFoundException implements Exception {
  @override
  String toString() {
    return "User not found";
  }
}
class WrongEmailOrPasswordAuthException implements Exception {
  @override
  String toString() {
    return "Wrong email or password";
  }
}

class DataLoadError implements Exception {
  @override
  String toString() {
    return "Не удалось загрузить информацию";
  }
}