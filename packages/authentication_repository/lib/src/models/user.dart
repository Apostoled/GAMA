import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  // Email текущего пользователя
  final String email;
  // ID текущего пользователя
  final String id;
  // Имя текущего пользователя
  final String name;
  // Аватарка текущего пользователя
  final String photo;

  const User({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
  })  : assert(email != null),
        assert(id != null);

  static const empty = User(email: '', id: '', name: null, photo: null);

  @override
  List<Object> get props => [email, id, name, photo];
}
