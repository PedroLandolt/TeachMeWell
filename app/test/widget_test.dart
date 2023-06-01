import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test_driver.dart' as integration_test_driver;
import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'package:teachmewell/main.dart';

//Future<void> main() {
//  final config = FlutterTestConfiguration()
//      ..features = [Glob(r"features/*.feature")]
//      ..reporters = [
//        ProgressReporter(),
//        TestRunSummaryReporter(),
//        JsonReporter(path: './reports/report.json')
//      ]
//      ..stepDefinitions = []
//      ..customStepParameterDefinitions = []
//      ..restartAppBetweenScenarios = true
//      ..targetAppPath = "../lib/main.dart";
//  return GherkinRunner().execute(config);
//}

