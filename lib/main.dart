import 'package:flutter/widgets.dart';
import 'package:url_strategy/url_strategy.dart';

import './widgets/root.dart';

void main() {
  final parameters = Uri.base.queryParameters;

  setPathUrlStrategy();

  runApp(Root(parameters: parameters));
}
