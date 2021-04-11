import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GameEntity extends Equatable {
  final String name;
  final String id;

  GameEntity(this.name, this.id);

  Map<String, Object> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'GameEntity { name: $name, id: $id }';
  }

  static GameEntity fromJson(Map<String, Object> json) {
    return GameEntity(
      json['name'] as String,
      json['id'] as String,
    );
  }

  static GameEntity fromSnapshot(DocumentSnapshot snap) {
    return GameEntity(
      snap.get('name'),
      snap.id,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name': name,
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
