import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';

abstract class AbstractCoinsRepositories {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin> getCoinsDetails(String currencyCode);
}
