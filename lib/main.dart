import 'package:flutter/widgets.dart';
import 'package:url_strategy/url_strategy.dart';

import './widgets/root.dart';

const resultsKey = 'results';

void main() {
  final parameters = Uri.base.queryParameters;
  final resultsId = parameters.containsKey(resultsKey) ? parameters[resultsKey]! : '';

  setPathUrlStrategy();
  runApp(Root(resultsId: resultsId));
}
