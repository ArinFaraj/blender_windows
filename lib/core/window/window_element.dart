import 'package:flutter/material.dart';

abstract class WindowElement extends StatelessWidget {
  const WindowElement({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;
}
