import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gama_app/home/home.dart';
import 'package:main_repository/main_repository.dart';

class GamesListPanel extends StatefulWidget {
  GamesListPanel({Key key}) : super(key: key);
  @override
  _GamesListPanelState createState() => _GamesListPanelState();
}

class _GamesListPanelState extends State<GamesListPanel> {
  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<GamesListCubit, GamesListState>(
      builder: (context, state) {
        if (state is GamesListEmptyState) {
          return Center(
            child: Text(
              'Список игр пуст!',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state is GamesListLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is GamesListLoadedState) {
          List<Item> _games = generateItems(state.gamesList);
          return SingleChildScrollView(
            child: Container(
              // padding: EdgeInsets.only(top: 80),
              child: GamesList(games: _games),
            ),
          );
        }

        if (state is GamesListErrorState) {
          return Center(
            child: Text(
              'Ошибка загрузки списка игр!',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }
        return null;
      },
    );
  }
}

class GamesList extends StatefulWidget {
  final List<Item> games;
  GamesList({this.games});
  @override
  _GamesListState createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  @override
  Widget build(BuildContext context) {
    final List<Item> _games = widget.games;
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _games[index].isExpanded = !isExpanded;
        });
      },
      children: _games.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.name),
              enabled: item.enabled,
            );
          },
          body: ListTile(
            title: Text('Players: ${item.playersCount}'),
          ),
          // ExpandedItem(
          //   key: Key('$item.id'),
          //   players: item.playersCount,
          //   avgTime: item.avgTime,
          // ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    this.id,
    this.name,
    this.playersCount,
    this.avgTime,
    this.enabled,
    this.isExpanded = false,
  });

  final String id;
  final String name;
  final String playersCount;
  final String avgTime;
  final bool enabled;
  bool isExpanded;
}

class ExpandedItem extends StatelessWidget {
  final Key key;
  final String players;
  final String avgTime;
  final String info;

  ExpandedItem({
    @required this.key,
    this.players = '...',
    this.avgTime = '...',
    this.info = '...',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ListTile(
          title: Text('Players: $players'),
        ),
        ListTile(
          title: Text('Time: $avgTime'),
        ),
        ListTile(
          title: Text('Info: $info'),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {},
                label: Text('Играть'),
                icon: Icon(Icons.play_arrow_rounded),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text('Правила'),
                icon: Icon(Icons.info),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<Item> generateItems(List<Game> gamesList) {
  return List.generate(gamesList.length, (int index) {
    return Item(
      id: gamesList[index].id,
      name: gamesList[index].name,
      playersCount: gamesList[index].playersCount,
      avgTime: gamesList[index].avgTime,
      enabled: gamesList[index].enabled,
    );
  });
}
