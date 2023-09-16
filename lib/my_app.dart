import 'package:flutter/material.dart';

import 'feature/crypto_list/view/crypto_list_screen.dart';
import 'router/router.dart';
import 'theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      routes: routes,
      home: const CryptoListScreen(),
    );
  }
}
