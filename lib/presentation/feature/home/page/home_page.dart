import 'package:skillbox_navigation/presentation/core/constants/route_name.dart';
import 'package:skillbox_navigation/presentation/widgets/home_drawer/home_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(
        activeRouteName: RouteName.homePage,
      ),
      appBar: AppBar(
        title: Text('Routes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Routes',
            ),
          ],
        ),
      ),
    );
  }
}
