import 'package:flutter/material.dart';

import 'core/constants/navigation/navigation_constants.dart';
import 'core/utils/navigation/navigation_service.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NavigationService.instance
                .navigateToPage(path: NavigationConstants.homePage);
          },
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
