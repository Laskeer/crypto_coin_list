import 'dart:async';

import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);

  await Hive.initFlutter();
  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>('crypto_coins_box');

  final dio = Dio();
  dio.interceptors.add(TalkerDioLogger(
    settings: const TalkerDioLoggerSettings(printResponseData: false),
  ));

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
        printEventFullData: false, printStateFullData: false),
  );

  GetIt.I.registerLazySingleton<AbstractCoinsRepositories>(
      () => CryptoCoinsRepositories(dio: dio, cryptoCoinsBox: cryptoCoinsBox));

  FlutterError.onError = (detail) {
    GetIt.I<Talker>().handle(detail.exception, detail.stack);
  };

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    talker.info(app.options.projectId);

    runApp(const MyApp());
  }, (error, stack) {
    GetIt.I<Talker>().handle(error, stack);
  });
}
