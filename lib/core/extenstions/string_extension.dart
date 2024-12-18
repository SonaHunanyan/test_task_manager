extension StringExtension on String {
  String toFlagEmojy() {
    return toUpperCase()
        .codeUnits
        .map((code) => String.fromCharCode(code + 0x1F1A5))
        .join();
  }
}
