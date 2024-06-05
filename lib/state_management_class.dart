import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/authentication/authentication_provider.dart';
import 'features/navigation/navigation_provider.dart';

class StateManagementClass extends StatelessWidget {
  final child;
  const StateManagementClass({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ChangeNotifierProvider(
          create: (context) => LocalAuthenticationProvider()),
    ], child: child);
  }
}
