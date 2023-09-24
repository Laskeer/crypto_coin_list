import 'package:crypto_coins_list/feature/crypto_coin/crypto_coin.dart';
import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/feature/crypto_list/view/crypto_list_screen.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CryptoListRoute.page, path: '/'),
        AutoRoute(page: CryptoCoinRoute.page),
      ];
}               

// final routes = {
//   '': (context) => const CryptoListScreen(),
//   '/coin': (context) => const CryptoCoinScreen()
// };

