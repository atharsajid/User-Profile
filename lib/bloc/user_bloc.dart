import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UploadImageEvent) {
        emit(UserLoading());
        final FirebaseStorage storage = FirebaseStorage.instance;
        try {
          await storage.ref("UserImage/${event.fileName}").putFile(event.file);
          String imageUrl = await storage.ref('UserImage/${event.fileName}').getDownloadURL();
          emit(UserLoaded(imageUrl: imageUrl));
        } on FirebaseException catch (e) {
          emit(UserError());
          log(e.toString());
        }
      }
      if (event is UploadDataEvent) {
        try {
          emit(UserLoading());

          await FirebaseFirestore.instance.collection("User").doc(event.email).set({
            "name": event.name,
            "email": event.email,
            "image": event.image,
          });
          emit(UserLoaded(dataUploaded: true));
        } catch (e) {
          emit(UserError());
          log(e.toString());
        }
      }
    });
  }
}
