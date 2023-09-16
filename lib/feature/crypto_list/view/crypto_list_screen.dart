import 'dart:async';

import 'package:crypto_coins_list/feature/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/feature/crypto_list/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepositories>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CryptoCurrenciesList'),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              _cryptoListBloc.add(LoadCryptoList(completer: completer));
              return completer.future;
            },
            child: BlocBuilder<CryptoListBloc, CryptoListState>(
                bloc: _cryptoListBloc,
                builder: (context, state) {
                  if (state is CryptoListLoaded) {
                    return ListView.separated(
                        padding: const EdgeInsets.only(top: 15),
                        itemCount: state.coinsList.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, i) {
                          final coin = state.coinsList[i];
                          return CryptoCoinTitle(coin: coin);
                        });
                  }
                  if (state is CryptoListLoadingFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Something went wrong',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                            'Pleace try againg later',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const SizedBox(height: 30),
                          TextButton(
                              onPressed: () {
                                _cryptoListBloc.add(LoadCryptoList());
                              },
                              child: const Text('Try againg'))
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                })));
  }
}
