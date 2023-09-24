import 'package:flutter/material.dart';

class CryptoCoinCard extends StatelessWidget {
  const CryptoCoinCard({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 20),
        color: const Color.fromARGB(255, 45, 45, 45),
        child: SizedBox(
            width: 350,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: child,
            )));
  }
}
