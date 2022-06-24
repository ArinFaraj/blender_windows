// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:blender_flutter/core/window/window_box.dart';
import 'package:blender_flutter/core/window/window_group.dart';
import 'package:blender_flutter/core/window/window_manager.dart';
import 'package:blender_flutter/counter/counter.dart';
import 'package:blender_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: const WindowManager(
        initialWindows: WindowGroup(
          WindowGroupType.column,
          id: 1314,
          children: [
            WindowBox(
              id: 13566,
              child: Text('hi old 1'),
            ),
            WindowGroup(
              WindowGroupType.row,
              id: 4683,
              children: [
                WindowBox(
                  id: 46583,
                  child: Text('hi old 2'),
                ),
                WindowBox(
                  id: 467883,
                  child: Text('hi old 3'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
