import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prime_template/features/authentication/authentication_provider.dart';
import 'package:prime_template/features/profile/components/action_card.dart';
import 'package:prime_template/utils/colors.dart';
import 'package:prime_template/utils/constants.dart';
import 'package:prime_template/utils/petite_storage.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String getName() {
    try {
      var name = FirebaseAuth.instance.currentUser!.displayName ??
          StorageUtil.getString(key: 'name');
      if (name.isEmpty) {
        context.read<LocalAuthenticationProvider>().logout(context);
      }
      return name;
    } catch (e) {
      return StorageUtil.getString(key: 'name');
    }
  }

  String getEmail() {
    try {
      var email = FirebaseAuth.instance.currentUser!.displayName ??
          StorageUtil.getString(key: 'email');
      return email;
    } catch (e) {
      return StorageUtil.getString(key: 'email');
    }
  }

  @override
  Widget build(BuildContext context) {
    var spaceY = SizedBox(
      height: pH(20, context),
    );
    return Scaffold(
      backgroundColor: profileBackground,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: profileBackground,
      //   automaticallyImplyLeading: false,
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<LocalAuthenticationProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spaceY,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Profile",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Container(
                      height: pH(150, context),
                      width: pH(150, context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: profileAvatar,
                      ),
                      child: Center(
                        child: Text(
                          getName().split(' ').first[0],
                          style: TextStyle(fontSize: 34),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    getName(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    getEmail(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ActionCard(tag: "Contact Info", svg: 'contact'),
                  ActionCard(tag: "Source of Funding Info", svg: 'fund'),
                  ActionCard(tag: "Bank Account Info", svg: 'bank'),
                  ActionCard(tag: "Document Info", svg: 'doc'),
                  ActionCard(tag: "Settings", svg: 'setting'),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Logout'),
                              content: Text('Are you sure you want to logout?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Logout'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    context
                                        .read<LocalAuthenticationProvider>()
                                        .logout(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Logout ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ).animate().fadeIn(),
            );
          },
        ),
      ),
    );
  }
}
