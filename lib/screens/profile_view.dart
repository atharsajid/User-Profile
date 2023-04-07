import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_profile/screens/profile_screen_model.dart';
import 'package:user_profile/screens/widgets/cached_network_image.dart';
import 'package:user_profile/screens/widgets/custom_text_widget.dart';
import 'package:user_profile/services/spacing.dart';

class ProfileView extends StatelessWidget {
  final ProfileScreenModel model;
  const ProfileView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile View'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: model.onFetchData(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Card(
                              child: CustomCachedNetworkImage(imageUrl: model.imageUrl),
                            ),
                          ),
                          Spacing.vMedium,
                          Row(
                            children: [
                              CustomTextWidget(text: 'Name: ${data['name']}'),
                            ],
                          ),
                          Spacing.vStandard,
                          Row(
                            children: [
                              CustomTextWidget(text: 'Email: ${data['email']}'),
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList());
            }),
      ),
    );
  }
}
