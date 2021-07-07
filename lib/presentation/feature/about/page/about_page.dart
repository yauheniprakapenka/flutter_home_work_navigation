import 'package:skillbox_navigation/data/models/artists_dto.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final RouteSettings settings;

  AboutPage({
    required this.settings,
  })  : assert(settings.arguments != null),
        assert(settings.arguments is ArtistsDTO);

  @override
  Widget build(BuildContext context) {
    final artist = settings.arguments as ArtistsDTO;

    return Scaffold(
      appBar: AppBar(
        title: Text(artist.name),
      ),
      body: SingleChildScrollView(
        child: Text(artist.about),
      ),
    );
  }
}
