import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile/bloc/user_bloc.dart';
import 'package:user_profile/screens/profile_screen_model.dart';
import 'package:user_profile/screens/profile_view.dart';
import 'package:user_profile/screens/widgets/cached_network_image.dart';
import 'package:user_profile/screens/widgets/custom_outline_button.dart';
import 'package:user_profile/screens/widgets/custom_textfield.dart';
import 'package:user_profile/services/spacing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileScreenModel model;
  @override
  void initState() {
    super.initState();
    model = ProfileScreenModel(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: model.userBloc,
      listener: (context, state) {
        if (state is UserLoading) {
          model.showMessage(message: 'Please wait...');
        } else if (state is UserError) {
          model.showMessage(message: 'Oops! Something went wrong.');
        }
      },
      buildWhen: (previousState, currentState) {
        if (currentState is UserLoaded) {
          if (currentState.imageUrl.isNotEmpty) {
            model.imageUrl = currentState.imageUrl;
            return true;
          } else if (currentState.dataUploaded) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileView(model: model),
                ));
          }
        }

        return false;
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Home Screen'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Card(
                        child: CustomCachedNetworkImage(imageUrl: model.imageUrl),
                      ),
                    ),
                    Spacing.vMedium,
                    CustomOutlineButton(
                      onPressed: () {
                        model.onUploadImage();
                      },
                      primaryColor: Colors.blue,
                      title: 'Upload Image',
                    ),
                    Spacing.vMedium,
                    CustomTextField(
                      controller: model.nameController,
                      prefixIcon: Icons.person,
                      hintText: 'Write your Name',
                    ),
                    Spacing.vMedium,
                    CustomTextField(
                      controller: model.emailController,
                      prefixIcon: Icons.email,
                      hintText: 'Write your email',
                    ),
                    Spacing.vMedium,
                    CustomOutlineButton(
                      onPressed: () => model.onUploadData(),
                      primaryColor: Colors.blue,
                      title: 'Upload Data',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
