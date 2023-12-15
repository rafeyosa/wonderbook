extension StringExtension on String? {
  bool get isNull => this == null;

  bool get isNotNull => this != null;

  bool get isNullOrEmpty => (this == null) || (this == '');

  bool get isEmpty => (this ?? '').isEmpty;

  bool get isNotEmpty => (this ?? '').isNotEmpty;

  String get orEmpty => this ?? '';
}