//Login exceptions
class UserNotFoundException implements Exception {
  @override
  String toString() {
    return "Пользователь не найден";
  }
}
class WrongEmailOrPasswordAuthException implements Exception {
  @override
  String toString() {
    return "Неправильная почта или пароль";
  }
}