import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';

class CryptoCoinsRepositories implements AbstractCoinsRepositories {
  CryptoCoinsRepositories({required this.dio});

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BTB,SOL,MULTI,BCH,BNB,XVS,SUI&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'];
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
          name: e.key,
          priceInUSD: price,
          imageUrl: 'https://www.cryptocompare.com$imageUrl');
    }).toList();

    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoinDetail> getCoinsDetails(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final priceInUSD = usdData['PRICE'];
    final priceLow24Hour = usdData['LOW24HOUR'];
    final priceHigh24Hour = usdData['HIGH24HOUR'];
    final imageUrl = usdData['IMAGEURL'];

    return CryptoCoinDetail(
        name: currencyCode,
        imageUrl: 'https://www.cryptocompare.com$imageUrl',
        priceInUSD: priceInUSD,
        priceLow24Hour: priceLow24Hour,
        priceHigh24Hour: priceHigh24Hour);
  }
}
