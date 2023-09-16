import 'package:crypto_coins_list/feature/crypto_coin/bloc/crypto_coin_detail_bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/abstract_coins_repositories.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../crypto_coin.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  final _cryptoCoinDetailBloc =
      CryptoCoinDetailBloc(GetIt.I<AbstractCoinsRepositories>());

  CryptoCoin? coin;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is CryptoCoin, 'You must provide String args');
    coin = args as CryptoCoin;
    _cryptoCoinDetailBloc.add(LoadCryptoCoinDetails(currencyCode: coin!.name));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoCoinDetailBloc, CryptoCoinDetailState>(
        bloc: _cryptoCoinDetailBloc,
        builder: (context, state) {
          if (state is CryptoCoinDetailLoaded) {
            final coinDetail = state.coinDetail;
            return SingleChildScrollView(
                child: Center(
                    child: Column(children: [
              SizedBox(
                height: 150,
                child: Image.network(coinDetail.imageUrl),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child:
                    Text(coinDetail.name, style: theme.textTheme.labelMedium),
              ),
              CryptoCoinCard(
                  child: Text(
                '${coinDetail.priceInUSD} \$',
                style: theme.textTheme.labelMedium,
              )),
              CryptoCoinCard(
                  child: Column(children: [
                CryptoCoinRow(
                    title: 'Low 24 Hour',
                    value: '${coinDetail.priceLow24Hour} \$'),
                CryptoCoinRow(
                    title: 'High 24 Hour',
                    value: '${coinDetail.priceHigh24Hour} \$')
              ]))
            ])));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
