import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/models.dart';

// Репозиторий, который управляет основными данными приложения
class MainRepository {
  final _gamesCollection = FirebaseFirestore.instance.collection('Games');

  //Получение списка игр
  Future<List<Game>> getGamesList() async {
    try {
      QuerySnapshot querySnapshot = await _gamesCollection.get();

      // Get data from docs and convert map to List
      return querySnapshot.docs.map((doc) {
        return doc == null
            ? Game.empty
            : Game(id: doc.id, name: doc.get('name'));
      }).toList();
    } catch (_) {
      throw Exception('Ошибка получения списка игр!');
    }
  }
}
