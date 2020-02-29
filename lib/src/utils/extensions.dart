extension ObjectUtils on Object {
  bool get isNull => this == null;

  bool get isNotNull => !isNull;
}

extension StringExtension on String {
  bool get isNullOrEmpty => this.isNull || this.isEmpty;
}

extension ListExtension on List {
  bool get isNullOrEmpty => this.isNull || this.isEmpty;
}
