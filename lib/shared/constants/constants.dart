printFullText(String text) {
  final pattern = RegExp('.{800}');
  pattern.allMatches(text).forEach(
        (match) => print(
          match.group(0),
        ),
      );
}


