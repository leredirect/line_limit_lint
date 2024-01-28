class Strings {
  static String lintName(int limit) => '${limit}_lines_limit_in_widgets';

  static String problemMessage(int limit) =>
      'The number of lines in the file exceeds ${limit}. Try '
      'reducing the number of lines.';

  static String matchFoundMessage(int limit) =>
      'Match found, limit set: $limit';

  static String incorrectLimitMessage(dynamic limit) =>
      'Incorrect limit: $limit';

  static final RegExp lintNameRegex = RegExp(r'^\d+_lines_limit_in_widgets$');
  static const String loadingMessage = 'Looking for match..';
  static const String notFoundMessage = 'Matches is not found';
  static const String stfulName = 'StatefulWidget';
  static const String stlessName = 'StatelessWidget';
}
