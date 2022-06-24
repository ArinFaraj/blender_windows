import 'package:blender_flutter/core/window/window_element.dart';
import 'package:flutter/material.dart';

class WindowGroup extends WindowElement {
  const WindowGroup(
    this.type, {
    Key? key,
    required int id,
    required this.children,
  }) : super(key: key, id: id);

  final List<WindowElement> children;
  final WindowGroupType type;

  @override
  Widget build(BuildContext context) {
    final isRoot = context.findAncestorWidgetOfExactType<WindowGroup>() == null;
    if (isRoot) {
      switch (type) {
        case WindowGroupType.row:
          return Row(
            children: children,
          );
        case WindowGroupType.column:
          return Column(
            children: children,
          );
      }
    } else {
      switch (type) {
        case WindowGroupType.row:
          return Expanded(
            flex: 1000,
            child: Row(
              children: children,
            ),
          );
        case WindowGroupType.column:
          return Expanded(
            flex: 1000,
            child: Column(
              children: children,
            ),
          );
      }
    }
  }
}

enum WindowGroupType {
  row,
  column,
}
