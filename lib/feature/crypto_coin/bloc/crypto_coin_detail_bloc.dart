import 'package:bloc/bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';

part 'crypto_coin_detail_event.dart';
part 'crypto_coin_detail_state.dart';

class CryptoCoinDetailBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailState> {
  CryptoCoinDetailBloc(this.coinsRepositories)
      : super(CryptoCoinDetailInitial()) {
    on<LoadCryptoCoinDetails>((event, emit) async {
      try {
        if (state is! CryptoCoinDetailLoaded) {
          emit(CryptoCoinDetailLoading());
        }
        final coinDetail =
            await coinsRepositories.getCoinsDetails(event.currencyCode);
        emit(CryptoCoinDetailLoaded(coinDetail: coinDetail));
      } catch (e) {
        emit(CryptoCoinDetailLoadingFailure(exception: e));
      }
    });
  }
  final AbstractCoinsRepositories coinsRepositories;
}