part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String imageUrl;
  final bool dataUploaded;
  UserLoaded({
    this.imageUrl = '',
    this.dataUploaded = false,
  });
}

class UserError extends UserState {}
