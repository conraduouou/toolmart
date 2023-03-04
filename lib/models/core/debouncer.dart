import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int? milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds ?? 500), action);
  }
}
