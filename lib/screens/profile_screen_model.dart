import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:user_profile/bloc/user_bloc.dart';
import 'package:user_profile/services/helper_funtions.dart';

class ProfileScreenModel {
  final BuildContext _context;
  ProfileScreenModel({
    required BuildContext context,
  }) : _context = context;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String imageUrl = '';
  UserBloc userBloc = UserBloc();

  Future<void> onUploadImage() async {
    final results = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "jpeg"],
    );

    if (results != null) {
      if (results.files.single.path != null) {
        userBloc.add(UploadImageEvent(fileName: results.files.single.name, file: File(results.files.single.path!)));
      }
    } else {
      showMessage(message: 'No File Selected, Kindly select your Ads Image');
    }
  }

  void onUploadData() {
    if (nameController.text.isEmpty) {
      showMessage(message: 'Please fill your name');
    } else if (emailController.text.isEmpty) {
      showMessage(message: 'Please fill your email address');
    } else if (!HelperFunctions.validateEmail(emailController.text)) {
      showMessage(message: 'Please enter valid email address');
    } else if (imageUrl.isEmpty) {
      showMessage(message: 'Please Select an Image');
    } else {
      userBloc.add(UploadDataEvent(name: nameController.text, email: emailController.text, image: imageUrl));
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> onFetchData() {
    return FirebaseFirestore.instance.collection("User").snapshots();
  }

  void showMessage({required String message}) {
    ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text(message)));
  }
}
