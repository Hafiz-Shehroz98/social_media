import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/viewModel/profile/profile_controller.dart';

import '../../../res/color.dart';
import '../../../res/component/round_button.dart';
import '../../../utils/routes/route_name.dart';
import '../../../viewModel/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('User');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(builder: (context, provider, child) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: StreamBuilder(
              stream: ref.child(SessionController().userId.toString()).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primaryTextTextColor,
                                  ),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: provider.image == null
                                        ? map['profile'].toString() == ''
                                            ? const Icon(
                                                Icons.person_outline,
                                                size: 35,
                                              )
                                            : Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    map['profile'].toString()),
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                                errorBuilder:
                                                    (context, stack, object) {
                                                  return const Icon(
                                                    Icons.error_outline,
                                                    color: AppColors.alertColor,
                                                  );
                                                })
                                        : Stack(
                                            children: [
                                              Image.file(
                                                  fit: BoxFit.cover,
                                                  File(provider.image!.path)
                                                      .absolute),
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            ],
                                          )),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              provider.pickImage(context);
                            },
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.primaryTextTextColor,
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ReuseableRow(
                          title: 'Username',
                          value: map['username'],
                          iconData: Icons.person_outline),
                      ReuseableRow(
                          title: 'Phone',
                          value: map['phone'] == ''
                              ? 'xxx-xxxx-xxx'
                              : map['phone'],
                          iconData: Icons.phone_outlined),
                      ReuseableRow(
                          title: 'Email',
                          value: map['email'],
                          iconData: Icons.email_outlined),
                      const SizedBox(
                        height: 40,
                      ),
                      RoundButton(
                          title: 'Logout',
                          onPress: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut().then((value) {
                              SessionController().userId = '';
                              Navigator.pushNamed(
                                  context, RouteName.loginScreen);
                            });
                          })
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                }
              },
            ),
          ));
        }),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReuseableRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.4),
        ),
      ],
    );
  }
}
