# Line Limit Lint

## Overview

This lint rule is designed to highlight Flutter widget files that exceed a specified size threshold.  
The purpose is to encourage developers to keep widget files concise and focused.

## Installation

1. Add the following dependency to your `pubspec.yaml` file:

```yaml  
dev_dependencies:
  line_limit_lint: any
  custom_lint: any  
```  

2. Run `flutter pub get` to fetch the dependency.

## Configuration

In your project's analysis_options.yaml file, add the following configuration:

```yaml  
analyzer:  
  plugins:  
    - custom_lint  
custom_lint:  
  rules:  
  - $your_limit$_lines_limit_in_widgets: true  
```  

You can set any limit:

```yaml  
custom_lint:  
  rules:  
    - 150_lines_limit_in_widgets: true  
```  
If the rule is not specified explicitly or incorrect data is specified, the standard limit will be
included - **120** lines
You can find more information about custom list rules here:
https://invertase.io/blog/custom-linter-rules

## Usage

After installation and configuration, run `flutter pub get` and `dart run custom lint`.  
It take some time for fetching all your files.

Any widget files exceeding the specified size threshold will be highlighted as lint warnings.

## Error logging

You can find information about error logging here:
https://pub.dev/packages/custom_lint#obtaining-the-list-of-lints-in-the-ci