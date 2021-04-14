import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/models.dart';

// Репозиторий, который управляет основными данными приложения
class MainRepository {
  final _gamesCollection = FirebaseFirestore.instance.collection('Games');

  Stream<List<Game>> get games {
    return _gamesCollection.snapshots().map((snapshot) {
      return snapshot.docs == null
          ? Game.empty
          : snapshot.docs
              .map((doc) => Game(id: doc.id, name: doc.get('name')))
              .toList();
    });
  }
}
