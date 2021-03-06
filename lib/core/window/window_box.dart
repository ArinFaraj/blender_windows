import 'dart:math';

import 'package:blender_flutter/core/window/enum/corner.dart';
import 'package:blender_flutter/core/window/enum/side.dart';
import 'package:blender_flutter/core/window/window_element.dart';
import 'package:blender_flutter/core/window/window_manager.dart';
import 'package:flutter/material.dart';

class WindowBox extends WindowElement {
  const WindowBox({
    Key? key,
    required int id,
    required this.child,
  }) : super(key: key, id: id);

  final double width = 40;
  final double height = 40;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WindowBody(
      id: id,
      child: child,
    );
  }
}

class WindowBody extends StatefulWidget {
  const WindowBody({
    Key? key,
    required this.child,
    required this.id,
  }) : super(key: key);

  final Widget child;

  final int id;

  @override
  State<WindowBody> createState() => _WindowBodyState();
}

class _WindowBodyState extends State<WindowBody> {
  int flex = 1000;

  void addSibling(BuildContext context, Side alignment) {
    final k = context.findAncestorStateOfType<WindowManagerState>();
    k?.addNewWindow(
      WindowBox(id: Random().nextInt(18000654), child: const Text('newWind')),
      context.findAncestorWidgetOfExactType()!,
      alignment,
    );
  }

  @override
  void initState() {
    super.initState();
    print('initState ${widget.id}');
  }

  void mergeSibling(
    BuildContext context,
    Side side,
    Corner corner,
  ) {
    final k = context.findAncestorStateOfType<WindowManagerState>();
    k?.mergeWindow(context.findAncestorWidgetOfExactType()!, side, corner);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SizedBox.expand(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: randomNiceColor(widget.child.hashCode + 3),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: SizedBox.expand(
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              addSibling(context, Side.top);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(35, 35),
                            ),
                            child: const Icon(
                              Icons.window_rounded,
                              size: 14,
                            ),
                          ),
                          Text(widget.id.toString()),
                        ],
                      ),
                      Positioned(
                        top: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: widget.child,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onHorizontalDragUpdate: (x) {
                  print(flex);
                  setState(() {
                    flex = (flex + x.delta.dx.toInt()).clamp(100, 1900);
                  });
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.resizeRight,
                  child: SizedBox(
                    width: 4,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  print(flex);
                  setState(() {
                    flex = (flex - details.delta.dx.toInt()).clamp(100, 1900);
                  });
                },
                child: const MouseRegion(
                  cursor: SystemMouseCursors.resizeLeft,
                  child: SizedBox(
                    width: 4,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onVerticalDragUpdate: print,
                child: const MouseRegion(
                  cursor: SystemMouseCursors.resizeUp,
                  child: SizedBox(
                    height: 4,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragUpdate: print,
                child: const MouseRegion(
                  cursor: SystemMouseCursors.resizeDown,
                  child: SizedBox(
                    height: 4,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Pivoo(),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Pivoo(),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Pivoo(),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Pivoo(),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Pivoo(small: true),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Pivoo(small: true),
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Pivoo(small: true),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Pivoo(small: true),
            ),
          ],
        ),
      ),
    );
  }
}

class Pivoo extends StatelessWidget {
  const Pivoo({
    Key? key,
    this.small = false,
  }) : super(key: key);
  final bool small;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.allScroll,
      child: Container(
        color: randomNiceColor(small ? null : 12, 200),
        width: small ? 6 : 10,
        height: small ? 6 : 10,
      ),
    );
  }
}

Color randomNiceColor(int? seed, [int upto = 30]) {
  final random = Random(seed);
  final r = random.nextInt(upto);
  final g = random.nextInt(upto);
  final b = random.nextInt(upto);
  return Color.fromARGB(255, r, g, b);
}
