/// Figma "capitalize" text style: first letter of every word is upper-case.
String titleCase(String value) => value.replaceAllMapped(
      RegExp(r'(^|[\s\-—–/“‘"])([a-z])'),
      (m) => '${m[1]}${m[2]!.toUpperCase()}',
    );
