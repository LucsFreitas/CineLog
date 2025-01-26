import 'package:cine_log/app/core/modules/base_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

abstract class BaseModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  BaseModule({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> routers,
  })  : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => BasePage(
          bindings: _bindings,
          page: pageBuilder,
        ),
      ),
    );
  }
}
