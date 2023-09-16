import 'package:equatable/equatable.dart';

class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail(
      {required this.name,
      required this.priceInUSD,
      required this.imageUrl,
      required this.priceLow24Hour,
      required this.priceHigh24Hour});

  final String name;
  final double priceInUSD;
  final String imageUrl;
  final double priceLow24Hour;
  final double priceHigh24Hour;

  @override
  List<Object?> get props =>
      [name, priceInUSD, imageUrl, priceLow24Hour, priceHigh24Hour];
}
