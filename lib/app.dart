import 'package:authentication_repository/authentication_repository.dart';
import 'package:main_repository/main_repository.dart';
import 'package:gama_app/store/main.dart';
import 'package:gama_app/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gama_app/home/home.dart';
import 'package:gama_app/login/login.dart';
import 'package:gama_app/splash/splash.dart';
import 'package:gama_app/theme.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final MainRepository mainRepository;

  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.mainRepository,
  })  : assert(authenticationRepository != null),
        assert(mainRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<MainBloc>(
            create: (_) => MainBloc(
              mainRepository: mainRepository,
            ),
          ),
        ],
        child: AppView(),
      ),

      //  BlocProvider(
      //   create: (_) => AuthenticationBloc(
      //     authenticationRepository: authenticationRepository,
      //   ),
      //   child: AppView(),
      // ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
