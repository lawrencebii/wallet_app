import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prime_template/features/home/components/card_display_section.dart';
import 'package:prime_template/utils/colors.dart';
import 'package:prime_template/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../utils/petite_storage.dart';
import '../../authentication/authentication_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    var spaceY = SizedBox(
      height: pH(20, context),
    );
    return Scaffold(
      backgroundColor: profileBackground,
      appBar: AppBar(
        backgroundColor: profileBackground,
        leading: Padding(
          padding: EdgeInsetsDirectional.all(13),
          child: SvgPicture.asset(
            'assets/icons/menu.svg',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
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
                      "Welcome, ${getName().split(' ').firstOrNull}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: pH(140, context),
                    width: pW(380, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              blurRadius: 10,
                              color: primaryColor.withOpacity(0.05))
                        ]),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your total asset portfolio",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "N203,935",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: pH(50, context),
                              width: pW(120, context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffFEFFFE)),
                              child: Center(
                                child: Text(
                                  "Invest now",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  ...[spaceY, spaceY],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Best Plans",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xffFE555D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xffFE555D),
                      )
                    ],
                  ),
                  Container(
                    height: pH(240, context),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: CardDisplaySection(),
                    ),
                  ),
                  spaceY,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Investment Guide",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  spaceY,
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: pH(120, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: pW(300, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Basic type of investments",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff4F4F4F),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "This is how you set your foot for 2020 Stock market recession. What’s next ",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff474747),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: pH(70, context),
                          width: pH(70, context),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/guide1.png"))),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: pH(120, context),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: pW(300, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Basic type of investments",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff4F4F4F),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "What do you like to see? It’s a very different market from 2018. ",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff474747),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: pH(70, context),
                          width: pH(70, context),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/guide1.png"))),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: pH(120, context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: pW(300, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Basic type of investments",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff4F4F4F),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "This is how you set your foot for 2020 Stock market recession. What’s next ",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff474747),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: pH(70, context),
                          width: pH(70, context),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/guide1.png"))),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    height: pH(120, context),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: pW(300, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Basic type of investments",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff4F4F4F),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "What do you like to see? It’s a very different market from 2018. ",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff474747),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: pH(70, context),
                          width: pH(70, context),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/guide1.png"))),
                        ),
                      ],
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
