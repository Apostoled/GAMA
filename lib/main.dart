import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gama_app/app.dart';
import 'package:gama_app/simple_bloc_observer.dart';
import 'package:main_repository/main_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      mainRepository: MainRepository(),
    ),
  );
}
