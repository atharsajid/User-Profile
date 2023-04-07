part of 'user_bloc.dart';

abstract class UserEvent {}

class UploadImageEvent extends UserEvent {
  final File file;
  final String fileName;
  UploadImageEvent({
    required this.file,
    required this.fileName,
  });
}

class UploadDataEvent extends UserEvent {
  final String name;
  final String email;
  final String image;
  UploadDataEvent({
    required this.name,
    required this.email,
    required this.image,
  });
}

