import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gama_app/home/home.dart';

class GamesList extends StatelessWidget {
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
          return ListView.builder(
            itemCount: state.gamesList.length,
            itemBuilder: (context, index) => Container(
              color: index % 2 == 0 ? Colors.white : Colors.blue[50],
              child: ListTile(
                leading: Text(
                  'ID: ${state.gamesList[index].id}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Text(
                  '${state.gamesList[index].name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
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


class ExpansionPanelDemo extends StatefulWidget {
  ExpansionPanelDemo({Key key}) : super(key: key);

  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  List<Item> _books = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 80),
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _books[index].isExpanded = !isExpanded;
        });
      },
      children: _books.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Book $index',
      expandedValue: 'Details for Book $index goes here',
    );
  });
}