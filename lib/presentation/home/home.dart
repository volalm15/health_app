import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Text("Hellooooo :D"),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Log out"),
          )
        ],
      ),
    );
  }
}
