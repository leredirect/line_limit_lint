/// Contains logging messages and var names.
class Strings {
  /// Formats lint name.
  static String lintName(int limit) => '${limit}_lines_limit_in_widgets';

  /// Formats lint warning message.
  static String problemMessage(int limit) =>
      'The number of lines in the file exceeds $limit. Try '
      'reducing the number of lines.';

  /// Formats 'not found' log message.
  static String matchFoundMessage(int limit) =>
      'Match found, limit set: $limit';

  /// Formats 'incorrect limit' log message.
  static String incorrectLimitMessage(dynamic limit) =>
      'Incorrect limit: $limit';

  /// Regexp for mapping provided lint name.
  static final RegExp lintNameRegex = RegExp(r'^\d+_lines_limit_in_widgets$');

  /// Provides 'loading' log message.
  static const String loadingMessage = 'Looking for match..';

  /// Provides 'default rule enabled' log message.
  static const String defaultReturnMessage = 'Rule is not declared explicitly, '
      'enabling default limit: 120';

  /// Provides 'not found' log message.
  static const String notFoundMessage = 'Matches is not found';

  /// Provides 'StatefulWidget' widget name.
  static const String stfulName = 'StatefulWidget';

  /// Provides 'StatelessWidget' widget name.
  static const String stlessName = 'StatelessWidget';
}
