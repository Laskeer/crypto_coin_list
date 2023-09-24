import 'package:bloc/bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
        final coin =
            await coinsRepositories.getCoinsDetails(event.currencyCode);
        emit(CryptoCoinDetailLoaded(coin: coin));
      } catch (e, st) {
        emit(CryptoCoinDetailLoadingFailure(exception: e));
        GetIt.I<Talker>().handle(e, st);
      }
    });
  }
  final AbstractCoinsRepositories coinsRepositories;

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
