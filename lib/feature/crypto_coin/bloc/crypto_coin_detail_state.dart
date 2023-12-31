part of 'crypto_coin_detail_bloc.dart';

abstract class CryptoCoinDetailState extends Equatable {}

class CryptoCoinDetailInitial extends CryptoCoinDetailState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailLoading extends CryptoCoinDetailState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinDetailLoaded extends CryptoCoinDetailState {
  CryptoCoinDetailLoaded({required this.coin});

  final CryptoCoin coin;

  @override
  List<Object?> get props => [coin];
}

class CryptoCoinDetailLoadingFailure extends CryptoCoinDetailState {
  CryptoCoinDetailLoadingFailure({required this.exception});

  final Object? exception;

  @override
  List<Object?> get props => throw UnimplementedError();
}
