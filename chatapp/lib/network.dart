import 'package:chatapp/providers/randomDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final data = ref.watch(dataProvider);
        data.when(
          data: (data) {
            Text(data);
          },
          error: (error, stackTrace) {
            Text('Error');
          },
          loading: () {
            CircularProgressIndicator();
          },
        );
      },
    );
  }
}
