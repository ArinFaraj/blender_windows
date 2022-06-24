import 'dart:math';

import 'package:blender_flutter/core/window/window_box.dart';
import 'package:blender_flutter/core/window/window_element.dart';
import 'package:blender_flutter/core/window/window_group.dart';
import 'package:flutter/material.dart';

class WindowManager extends StatefulWidget {
  const WindowManager({
    Key? key,
    required this.initialWindows,
  }) : super(key: key);
  final WindowGroup initialWindows;

  @override
  State<WindowManager> createState() => WindowManagerState();
}

class WindowManagerState extends State<WindowManager> {
  late WindowGroup windowGroup;

  @override
  void initState() {
    super.initState();
    windowGroup = widget.initialWindows;
  }

  WindowGroup? _addNewWidnowToGroup(
    WindowGroup group,
    WindowBox window,
    WindowBox sibling,
    Alignment alignment,
  ) {
    print('doing group: ${group.id}');
    for (final child in group.children) {
      if (child is WindowGroup) {
        final newChild =
            _addNewWidnowToGroup(child, window, sibling, alignment);
        if (newChild != null) {
          return WindowGroup(
            group.type,
            id: group.id,
            children:
                group.children.map((e) => e == child ? newChild : e).toList(),
          );
        }
      } else if (child is WindowBox) {
        if (child.id == sibling.id) {
          print('found in group: ${group.id}');
          print('this group is: ${group.type}');
          switch (group.type) {
            case WindowGroupType.row:
              if (alignment == Alignment.centerLeft) {
                print('adding to center left');

                final childrr = group.children.indexOf(sibling);
                final newChildren = List<WindowElement>.from(group.children)
                  ..insert(childrr, window);
                final newGroup = WindowGroup(
                  group.type,
                  id: group.id,
                  children: newChildren,
                );
                return newGroup;
              } else if (alignment == Alignment.centerRight) {
                print('adding to center right');
                final childrr = group.children.indexOf(sibling) + 1;
                final newChildren = List<WindowElement>.from(group.children)
                  ..insert(childrr, window);
                final newGroup = WindowGroup(
                  group.type,
                  id: group.id,
                  children: newChildren,
                );
                return newGroup;
              } else {
                print('creating new vertical group');

                return WindowGroup(
                  group.type,
                  id: group.id,
                  children: group.children
                      .map(
                        (e) => e == sibling
                            ? WindowGroup(
                                WindowGroupType.column,
                                id: Random().nextInt(4861396),
                                children: alignment == Alignment.topCenter
                                    ? [
                                        window,
                                        sibling,
                                      ]
                                    : [
                                        sibling,
                                        window,
                                      ],
                              )
                            : e,
                      )
                      .toList(),
                );
              }
            case WindowGroupType.column:
              if (alignment == Alignment.topCenter) {
                print('adding to top center');
                final childrr = group.children.indexOf(sibling);
                final newChildren = List<WindowElement>.from(group.children)
                  ..insert(childrr, window);
                final newGroup = WindowGroup(
                  group.type,
                  id: group.id,
                  children: newChildren,
                );
                return newGroup;
              } else if (alignment == Alignment.bottomCenter) {
                print('adding to bottom center');
                final childrr = group.children.indexOf(sibling) + 1;
                final newChildren = List<WindowElement>.from(group.children)
                  ..insert(childrr, window);
                final newGroup = WindowGroup(
                  group.type,
                  id: group.id,
                  children: newChildren,
                );
                return newGroup;
              } else {
                // make a group and put both windows inside
                print('creating new horizontal group');
                return WindowGroup(
                  group.type,
                  id: group.id,
                  children: group.children
                      .map(
                        (e) => e == sibling
                            ? WindowGroup(
                                WindowGroupType.row,
                                id: Random().nextInt(4861396),
                                children: alignment == Alignment.centerLeft
                                    ? [
                                        window,
                                        sibling,
                                      ]
                                    : [
                                        sibling,
                                        window,
                                      ],
                              )
                            : e,
                      )
                      .toList(),
                );
              }
          }
        }
      }
    }
    return null;
  }

  void addNewWindow(WindowBox window, WindowBox sibling, Alignment alignment) {
    setState(() {
      windowGroup =
          _addNewWidnowToGroup(windowGroup, window, sibling, alignment) ??
              windowGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return windowGroup;
  }

  void removeWindow(WindowBox stayingWindow, Alignment alignment) {
    // removing the sibling window to the stayingWindow
    // we find the sibling window using the alignment
    // TODO(arin): implement this
    throw UnimplementedError();
  }
}
