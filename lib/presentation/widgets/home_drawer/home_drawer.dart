import 'package:skillbox_navigation/data/utils/parse_artists.dart';
import 'package:skillbox_navigation/data/utils/fetch_file_from_assets.dart';
import 'package:skillbox_navigation/presentation/core/constants/route_name.dart';
import 'package:skillbox_navigation/presentation/core/constants/strings.dart';
import 'package:skillbox_navigation/presentation/core/ui_helper/ui_helper.dart';
import 'package:skillbox_navigation/presentation/widgets/text_button/text_button.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final String activeRouteName;

  HomeDrawer({
    required this.activeRouteName,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.topPadding,
          CustomTextButton(
            title: Strings.home,
            isActive: _isHomeButtonActive(),
            onPressed: () {
              Navigator.pushNamed(context, RouteName.homePage);
            },
          ),
          CustomTextButton(
            title: Strings.albums,
            isActive: _isAlbumButtonActive(),
            onPressed: () async {
              final file = await fetchFileFromAssets('assets/artists.json');
              final parsedArtists = parseArtists(file);
              Navigator.pushNamed(
                context,
                RouteName.albumsPage,
                arguments: parsedArtists,
              );
            },
          )
        ],
      ),
    );
  }

  bool _isHomeButtonActive() {
    return activeRouteName == RouteName.homePage ? true : false;
  }

  bool _isAlbumButtonActive() {
    return activeRouteName == RouteName.albumsPage ? true : false;
  }
}
