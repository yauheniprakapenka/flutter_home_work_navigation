import 'package:skillbox_navigation/presentation/core/constants/route_name.dart';
import 'package:skillbox_navigation/presentation/feature/about/page/about_page.dart';
import 'package:skillbox_navigation/presentation/feature/albums/page/albums_page.dart';
import 'package:skillbox_navigation/presentation/feature/home/page/home_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSetting) {
  switch (routeSetting.name) {
    case RouteName.aboutPage:
      return MaterialPageRoute(
        builder: (context) {
          return AboutPage(
            settings: routeSetting,
          );
        },
      );
    case RouteName.albumsPage:
      return MaterialPageRoute(
        builder: (context) {
          return AlbumsPage(
            settings: routeSetting,
          );
        },
      );
    default:
      return MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      );
  }
}
