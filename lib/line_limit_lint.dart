import 'dart:developer';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:line_limit_lint/strings.dart';

typedef _S = Strings;

/// Entry point for 'custom_lint' package.
PluginBase createPlugin() => CustomLinter();

/// Describes lint entry behaviour.
class CustomLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    if (configs.rules.isEmpty) return defaultRule(m: _S.defaultReturnMessage);
    final keys = configs.rules.keys.toList();
    log(_S.loadingMessage);
    final hasMatches = keys.any(_S.lintNameRegex.hasMatch);
    if (!hasMatches) return defaultRule(m: _S.notFoundMessage);
    final rule = keys.firstWhere(_S.lintNameRegex.hasMatch);
    final limit = toInt(rule);
    if (limit == null) return defaultRule(m: _S.incorrectLimitMessage(rule));
    log(_S.matchFoundMessage(limit));
    return [LinesLimitLintCode(limit)];
  }
}

/// Shorthand for int parsing;
int? toInt(String raw) => int.tryParse(raw.split('_').first);

/// Provides default lint rule instance.
List<DartLintRule> defaultRule({String? m}) {
  if (m != null) log(m);
  return [LinesLimitLintCode(120)];
}

/// Describes lint rule behaviour.
class LinesLimitLintCode extends DartLintRule {
  /// Public constructor.
  LinesLimitLintCode(this.limit)
      : super(
          code: LintCode(
            name: _S.lintName(limit),
            problemMessage: _S.problemMessage(limit),
          ),
        );

  ///Limitation for analyzer.
  final int limit;

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addClassDeclaration(
      (node) {
        if (!_isWidget(node)) return;
        final content = resolver.source.contents.data;
        if (content.split(RegExp(r'\r\n|\n|\r')).length > limit) {
          reporter.reportErrorForOffset(super.code, 0, content.length);
        }
      },
    );
  }

  bool _isWidget(ClassDeclaration node) {
    if (node.extendsClause == null) return false;
    if (node.extendsClause!.superclass.element == null) return false;
    final superName = node.extendsClause!.superclass.element!.displayName;
    return superName == _S.stfulName || superName == _S.stlessName;
  }
}
