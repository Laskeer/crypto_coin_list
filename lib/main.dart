import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'my_app.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepositories>(
      () => CryptoCoinsRepositories(dio: Dio()));

  runApp(const MyApp());
}
