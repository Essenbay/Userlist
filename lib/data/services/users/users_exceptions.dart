class DataLoadError implements Exception {
  @override
  String toString() {
    return "Не удалось загрузить информацию";
  }
}