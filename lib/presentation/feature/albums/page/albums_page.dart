import 'package:skillbox_navigation/data/models/artists_dto.dart';
import 'package:skillbox_navigation/presentation/core/constants/route_name.dart';
import 'package:skillbox_navigation/presentation/widgets/home_drawer/home_drawer.dart';
import 'package:skillbox_navigation/presentation/widgets/text_button/text_button.dart';
import 'package:flutter/material.dart';

part '../components/build_artist_list.dart';

class AlbumsPage extends StatelessWidget {
  final RouteSettings settings;

  AlbumsPage({
    required this.settings,
  })  : assert(settings.arguments != null),
        assert(settings.arguments is List<ArtistsDTO>);

  @override
  Widget build(BuildContext context) {
    final arguments = settings.arguments as List<ArtistsDTO>;
    final artists = _buildArtistList(arguments);

    return Scaffold(
      appBar: AppBar(),
      drawer: HomeDrawer(
        activeRouteName: RouteName.albumsPage,
      ),
      body: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return CustomTextButton(
            title: artists[index].name,
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteName.aboutPage,
                arguments: artists[index],
              );
            },
          );
        },
      ),
    );
  }
}
