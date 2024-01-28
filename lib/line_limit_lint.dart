import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:line_limit_lint/strings.dart';

typedef _S = Strings;

PluginBase createPlugin() => CustomLinter();

class CustomLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    if (configs.rules.isEmpty) return defaultRule();
    final List<String> keys = configs.rules.keys.toList();
    print(_S.loadingMessage);
    final bool hasMatches = keys.any((e) => _S.lintNameRegex.hasMatch(e));
    if (!hasMatches) return defaultRule(m: _S.notFoundMessage);
    final String rule = keys.firstWhere((e) => _S.lintNameRegex.hasMatch(e));
    final int? limit = toInt(rule);
    if (limit == null || limit.isNegative)
      return defaultRule(m: _S.incorrectLimitMessage(rule));
    print(_S.matchFoundMessage(limit));
    return [LinesLimitLintCode(limit)];
  }
}

int? toInt(String raw) => int.tryParse(raw.split('_').first);

List<DartLintRule> defaultRule({String? m}) {
  if (m != null) print(m);
  return [LinesLimitLintCode(120)];
}

class LinesLimitLintCode extends DartLintRule {
  final int limit;

  LinesLimitLintCode(this.limit)
      : super(
          code: LintCode(
            name: _S.lintName(limit),
            problemMessage: _S.problemMessage(limit),
          ),
        );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration(
      (node) {
        if (!_isWidget(node)) return;
        final String content = resolver.source.contents.data;
        if (content.split(RegExp(r'\r\n|\n|\r')).length > limit) {
          reporter.reportErrorForOffset(super.code, 0, content.length);
        }
      },
    );
  }

  bool _isWidget(ClassDeclaration node) {
    if (node.extendsClause == null) return false;
    if (node.extendsClause!.superclass.element == null) return false;
    final String superName =
        node.extendsClause!.superclass.element!.displayName;
    return superName == _S.stfulName || superName == _S.stlessName;
  }
}
