import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String id;
  const Auth({required this.id});

  @override
  List<Object?> get props => [id];
}