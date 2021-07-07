part of '../page/albums_page.dart';

List<ArtistsDTO> _buildArtistList(List<ArtistsDTO> artists) {
    var newArtists = <ArtistsDTO>[];

    artists.forEach((artist) {
      newArtists.add(artist);
    });

    return newArtists;
  }