import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_detail.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail(
      {required this.priceInUSD,
      required this.imageUrl,
      required this.priceLow24Hour,
      required this.priceHigh24Hour});

  @HiveField(0)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @HiveField(1)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  @HiveField(2)
  @JsonKey(name: 'LOW24HOUR')
  final double priceLow24Hour;

  @HiveField(3)
  @JsonKey(name: 'HIGH24HOUR')
  final double priceHigh24Hour;

  String get fullImageUrl => 'https://www.cryptocompare.com$imageUrl';

  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props =>
      [priceInUSD, imageUrl, priceLow24Hour, priceHigh24Hour];
}
