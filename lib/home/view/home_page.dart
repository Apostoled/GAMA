import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gama_app/authentication/authentication.dart';
import 'package:gama_app/home/home.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:gama_app/store/bloc/main_bloc.dart';
import 'package:main_repository/main_repository.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final games = context.select((MainBloc bloc) => bloc.state.games);
    AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      child: SizedBox(),
      drawer: SizedBox(),
    );

    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GAMA'),
          centerTitle: true,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (context, value, child) {
                return Icon(
                  value.visible ? Icons.clear : Icons.menu,
                );
              },
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(2),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Avatar(
                    photo: user.photo,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          user.name ?? '',
                          style: textTheme.headline5,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              key: const Key('homePage_stats_iconbutton'),
                              icon: const Icon(Icons.bar_chart_rounded),
                              iconSize: 35,
                              onPressed: () => {},
                            ),
                            IconButton(
                              key: const Key('homePage_settings_iconbutton'),
                              icon: const Icon(Icons.settings),
                              iconSize: 35,
                              onPressed: () => print(games),
                            ),
                            IconButton(
                              key: const Key('homePage_logout_iconButton'),
                              icon: const Icon(Icons.exit_to_app),
                              onPressed: () => context
                                  .read<AuthenticationBloc>()
                                  .add(AuthenticationLogoutRequested()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Avatar(
                    photo: user.photo,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.name ?? '',
                  style: textTheme.headline5,
                ),
                ListTile(
                  key: const Key('HomePage_profile_drawerItem'),
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  key: const Key('HomePage_Statistics_drawerItem'),
                  onTap: () {},
                  leading: Icon(Icons.bar_chart_rounded),
                  title: Text('Statistics'),
                ),
                ListTile(
                  key: const Key('HomePage_LogOut_drawerItem'),
                  onTap: () => context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested()),
                  leading: Icon(Icons.logout),
                  title: Text('LogOut'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
