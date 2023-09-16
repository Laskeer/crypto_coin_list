import 'package:crypto_coins_list/feature/crypto_coin/crypto_coin.dart';

import '../feature/crypto_list/crypto_list.dart';

final routes = {
  '': (context) => const CryptoListScreen(),
  '/coin': (context) => const CryptoCoinScreen()
};
